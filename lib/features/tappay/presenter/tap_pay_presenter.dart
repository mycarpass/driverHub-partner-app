// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/tappay/interactor/tap_pay_interactor.dart';
import 'package:driver_hub_partner/features/tappay/presenter/tap_pay_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';

class TapPayPresenter extends Cubit<DHState> {
  TapPayPresenter() : super(DHInitialState());

  final TapPayInterector _tapPayInterector =
      DHInjector.instance.get<TapPayInterector>();

  StreamSubscription? _onConnectionStatusChangeSub;
  var _connectionStatus = ConnectionStatus.notConnected;
  StreamSubscription? _onPaymentStatusChangeSub;
  PaymentStatus _paymentStatus = PaymentStatus.notReady;
  StreamSubscription? _onUnexpectedReaderDisconnectSub;
  Terminal? _terminal;
  var _locations = <Location>[];
  Location? _selectedLocation;

  StreamSubscription? _discoverReaderSub;
  List<Reader> _readers = [];
  bool _isSimulated = true;
  Reader? _reader;

  var amount = "17.25";
  PaymentIntent? _paymentIntent;
  CancelableFuture<PaymentIntent>? _collectingPaymentMethod;

  bool _isPaymentCollected = false;

  // Future _g() async {
  //   try {
  //     emit(DHLoadingState());
  //     homeResponseDto = await _tapPayInterector.getConnectionToken();
  //     emit(HomeLoaded(homeResponseDto));
  //   } catch (e) {
  //     emit(DHErrorState());
  //   }
  // }

  Future<void> _initTerminal() async {
    await requestPermissions();
    emit(DHLoadingState());
    final connectionToken = await _tapPayInterector.getConnectionToken();
    final terminal = await Terminal.getInstance(
      shouldPrintLogs: false,
      fetchToken: () async {
        return connectionToken;
      },
    );
    _terminal = terminal;
    _onConnectionStatusChangeSub =
        terminal.onConnectionStatusChange.listen((status) {
      print('Connection Status Changed: ${status.name}');
      _connectionStatus = status;
    });
    _onUnexpectedReaderDisconnectSub =
        terminal.onUnexpectedReaderDisconnect.listen((reader) {
      print('Reader Unexpected Disconnected: ${reader.label}');
    });
    _onPaymentStatusChangeSub = terminal.onPaymentStatusChange.listen((status) {
      print('Payment Status Changed: ${status.name}');
      _paymentStatus = status;
    });
    if (_terminal == null) {
      _showSnackBar('Please try again later!');
    }

    emit(OnTerminalFinishedState());
    //setState(() {});
  }

  Future<void> _fetchLocations(Terminal terminal) async {
    _locations = const [];
    final locations = await terminal.listLocations();
    _locations = locations;
    _selectedLocation = locations.first;
    if (_selectedLocation == null) {
      _showSnackBar(
          'Please create location on stripe dashboard to proceed further!');
    }
    emit(OnLocationFinishedState());
  }

  void _showSnackBar(String message) {
    DHSnackBar().showSnackBar("Atenção", message, DHSnackBarType.error);
  }

  Future<void> requestPermissions() async {
    final permissions = [
      Permission.locationWhenInUse,
      Permission.bluetooth,
      if (Platform.isAndroid) ...[
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ],
    ];

    for (final permission in permissions) {
      final result = await permission.request();
      if (result == PermissionStatus.denied ||
          result == PermissionStatus.permanentlyDenied) return;
    }
  }

  Future<void> _startDiscoverReaders(Terminal terminal) async {
    _readers = [];
    final discoverReaderStream =
        terminal.discoverReaders(LocalMobileDiscoveryConfiguration(
      isSimulated: _isSimulated,
    ));
    _discoverReaderSub = discoverReaderStream.listen(
        (readers) async {
          _readers.addAll(readers);
          //after getting all the available readers its time to select any one reader and connect it
          await _connectReader(terminal, _readers.first);
          // setState(() {});
        },
        onError: (e) {},
        cancelOnError: true,
        onDone: () {
          _showSnackBar('reader discovered done!');
          _discoverReaderSub = null;
          _readers = [];
          //setState(() {});
        });
    //   setState(() {});
  }

  Future<void> _connectReader(Terminal terminal, Reader reader) async {
    await _tryConnectReader(terminal, reader).then((value) {
      final connectedReader = value;
      if (connectedReader == null) {
        print("return");
      }
      _showSnackBar(
          'Connected to a device: ${connectedReader!.label ?? connectedReader.serialNumber}');
      _reader = connectedReader;

      // setState(() {});
    });
  }

  Future<Reader?> _tryConnectReader(Terminal terminal, Reader reader) async {
    String? getLocationId() {
      final locationId = _selectedLocation?.id ?? reader.locationId;
      if (locationId == null) _showSnackBar('Missing location');
      return locationId;
    }

    final locationId = getLocationId();
    return await terminal.connectMobileReader(
      reader,
      locationId: locationId!,
    );
  }

  Future<void> _createPaymentIntent(Terminal terminal) async {
    final paymentIntent =
        await terminal.createPaymentIntent(PaymentIntentParameters(
      amount:
          (double.parse(double.parse(amount).toStringAsFixed(2)) * 100).ceil(),
      currency: "BRL", // your currency
      captureMethod: CaptureMethod.automatic,
      paymentMethodTypes: [PaymentMethodType.cardPresent],
    ));
    _paymentIntent = paymentIntent;

    if (_paymentIntent == null) {
      _showSnackBar('Payment intent is not created!');
    }
    _showSnackBar('Payment intent created!');
    //setState(() {});
  }

  Future<void> _collectPaymentMethod(
      Terminal terminal, PaymentIntent paymentIntent) async {
    final collectingPaymentMethod = terminal.collectPaymentMethod(
      paymentIntent,
      skipTipping: true,
    );
    // setState(() {
    _collectingPaymentMethod = collectingPaymentMethod;
    //});

    try {
      final paymentIntentWithPaymentMethod = await collectingPaymentMethod;
      _paymentIntent = paymentIntentWithPaymentMethod;
      _collectingPaymentMethod = null;
      _isPaymentCollected = true;
      // setState(() {});
      _showSnackBar('Payment method collected!');

      await _confirmPaymentIntent(_terminal!, _paymentIntent!).then((value) {
        // setState(() {});
      });
    } on TerminalException catch (exception) {
      _collectingPaymentMethod = null;
      switch (exception.code) {
        case TerminalExceptionCode.canceled:
          _showSnackBar('Collecting Payment method is cancelled!');
        default:
          rethrow;
      }
    }
    if (_isPaymentCollected == false) {
      _showSnackBar('Payment method is not collected!');
    }
  }

  Future<void> _confirmPaymentIntent(
      Terminal terminal, PaymentIntent paymentIntent) async {
    final processedPaymentIntent =
        await terminal.confirmPaymentIntent(paymentIntent);
    _paymentIntent = processedPaymentIntent;
    // setState(() => _paymentIntent = processedPaymentIntent);
    _showSnackBar('Payment processed!');
    // navigate to payment success screen
  }

  proceedTapToPay() async {
    emit(DHLoadingState());
    //setState(() {});
    await _initTerminal();
    await _fetchLocations(_terminal!);
    await _startDiscoverReaders(_terminal!).then((value) async {
      await _createPaymentIntent(_terminal!);
      await _collectPaymentMethod(_terminal!, _paymentIntent!);
      // isLoading = false;
      //  setState(() {});
      emit(DHSuccessState());
    });
  }
}

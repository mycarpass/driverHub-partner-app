import 'package:dh_state_management/dh_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ReceiptPresenter extends Cubit<DHState> {
  ReceiptPresenter() : super(DHInitialState());

  WidgetsToImageController controller = WidgetsToImageController();
  // to save image bytes of widget
  Uint8List? bytes;

  Future<void> saveImage() async {
    try {
      bytes = await controller.capture();
      final DateTime now = DateTime.now();
      String fileName =
          "DH-Comprovante-Agendamento-${now.microsecondsSinceEpoch}.png";
      await ImageGallerySaver.saveImage(bytes!, name: fileName);
      emit(ImageSavedSuccessful(fileName));
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future<void> shareWhatsApp(String phone, String message) async {
    try {
      bytes = await controller.capture();
      final DateTime now = DateTime.now();
      String fileName =
          "DH-Comprovante-Agendamento-${now.microsecondsSinceEpoch}.png";
      await ImageGallerySaver.saveImage(bytes!, name: fileName);

      FlutterShareMe().shareWhatsAppPersonalMessage(
          message: message, phoneNumber: "55$phone");

      emit(ImageSharedSuccessful(fileName));
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void openUrl(Uri uri) async {
    await canLaunchUrl(uri) ? _launchInBrowser(uri) : null;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class ImageSavedSuccessful extends DHSuccessState {
  final String fileName;
  ImageSavedSuccessful(this.fileName);

  @override
  List<Object> get props => [fileName];
}

class ImageSharedSuccessful extends DHSuccessState {
  final String fileName;
  ImageSharedSuccessful(this.fileName);

  @override
  List<Object> get props => [fileName];
}

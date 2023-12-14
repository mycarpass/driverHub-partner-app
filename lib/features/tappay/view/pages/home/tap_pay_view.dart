// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/tappay/presenter/tap_pay_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TapPayView extends StatefulWidget {
  const TapPayView({super.key});

  @override
  State<TapPayView> createState() => _TapPayViewState();
}

class _TapPayViewState extends State<TapPayView> {
  @override
  Widget build(BuildContext context) {
    var presenter = context.read<TapPayPresenter>();
    return Scaffold(
        body: BlocBuilder<TapPayPresenter, DHState>(
      builder: (context, state) => Stack(
        children: [
          if (state is DHLoadingState) ...[
            //  const HomeBodyLoading()
          ] else if (state is DHErrorState) ...[
            //   const HomeErrorWidget()
          ] else ...[
            Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 0, bottom: 12, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          presenter.proceedTapToPay();
                        },
                        child: const Text('clique aqui'))
                  ],
                )),
          ]
        ],
      ),
    ));
  }
}

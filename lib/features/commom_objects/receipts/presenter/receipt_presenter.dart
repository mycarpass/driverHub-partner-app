import 'dart:io';

import 'package:dh_state_management/dh_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

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

  Future<void> shareWhatsApp(String phone) async {
    try {
      bytes = await controller.capture();
      final DateTime now = DateTime.now();
      String fileName =
          "DH-Comprovante-Agendamento-${now.microsecondsSinceEpoch}.png";
      File file = File.fromRawPath(bytes!);
      print(file);
      await WhatsappShare.shareFile(
        phone: "5534991968372",
        filePath: [file.path],
      );

      emit(ImageSharedSuccessful(fileName));
    } catch (e) {
      emit(DHErrorState());
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

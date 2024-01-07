import 'package:image_picker/image_picker.dart';

class GetDeviceImageInteractor {
  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  Future<XFile?> captureImage() async {
    _image = await _picker.pickImage(
      ///TODO change to camera
      source: ImageSource.gallery,
    );
    return _image;
    // presenter.inputBackground(image);
  }
}

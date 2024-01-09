import 'package:image_picker/image_picker.dart';

class GetDeviceImageInteractor {
  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  Future<XFile?> captureImage() async {
    _image = await _picker.pickImage(
      source: ImageSource.camera,
    );
    return _image;
    // presenter.inputBackground(image);
  }
}

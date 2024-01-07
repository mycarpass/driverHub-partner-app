import 'package:dh_state_management/dh_state.dart';
import 'package:image_picker/image_picker.dart';

class CapturedPhotoState extends DHState {
  final XFile file;

  CapturedPhotoState(this.file);

  @override
  List<Object?> get props => [file];
}

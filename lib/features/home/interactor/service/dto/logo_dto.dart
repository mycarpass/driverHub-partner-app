import 'package:image_picker/image_picker.dart';

class LogoAccountDto {
  XFile? imageBackgroundFile;
  XFile? imageLogoFile;

  String? pathBackground;
  String? pathLogo;

  LogoAccountDto({
    this.imageBackgroundFile,
    this.imageLogoFile,
    this.pathBackground,
    this.pathLogo,
  });

  Map<String, dynamic> toJson() {
    return {
      "thumb": pathLogo,
      "background": pathBackground,
    };
  }
}

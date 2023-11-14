import 'package:driver_hub_partner/features/profile/view/pages/profile_view.dart';

abstract class ProfileRooutes {
  static const profileHome = "/home/profile";
}

abstract class ProfileRoutesMap {
  static var routes = {
    "/home/profile": (context) => const HomeProfileView(),
  };
}

import 'package:sailor/sailor.dart';
import 'package:vyaasa/ui/Profile.dart';
import 'package:vyaasa/ui/Shared.dart';

import '../ui/About.dart';
import '../ui/Help.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes([
      // Just for good measure, we won't explicitly navigate to the InitialPage.
      SailorRoute(
        name: '/about',
        builder: (context, args, params) {
          return About();
        },
      ),
      SailorRoute(
        name: '/help',
        builder: (context, args, params) {
          return Help();
        },
      ),
      SailorRoute(
        name: '/shared',
        builder: (context, args, params) {
          return SharedScrips();
        },
      ),
      SailorRoute(
        name: '/profile',
        builder: (context, args, params) {
          return Profile();
        },
      ),
      SailorRoute(
        name: '/signup',
        builder: (context, args, params) {
          return Profile();
        },
      ),
    ]);
  }
}

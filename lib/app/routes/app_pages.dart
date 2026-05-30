import 'package:flutter_live_streaming/app/modules/main/main_binding.dart';
import 'package:flutter_live_streaming/app/modules/main/main_view.dart';
import 'package:get/get.dart';

import '../modules/audience_live/audience_live_binding.dart';
import '../modules/audience_live/audience_live_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/host_live/host_live_binding.dart';
import '../modules/host_live/host_live_view.dart';
import '../modules/rtmp_settings/rtmp_settings_binding.dart';
import '../modules/rtmp_settings/rtmp_settings_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: "/home_page",
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Routes.host,
      page: () => const HostLiveView(),
      binding: HostLiveBinding(),
    ),

    GetPage(
      name: Routes.audience,
      page: () => const AudienceLiveView(),
      binding: AudienceLiveBinding(),
    ),

    GetPage(
      name: Routes.settings,
      page: () => const RtmpSettingsView(),
      binding: RtmpSettingsBinding(),
    ),
  ];
}

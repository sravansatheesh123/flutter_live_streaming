import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_bottom_nav.dart';
import '../audience_live/audience_live_view.dart';
import '../home/home_view.dart';
import '../host_live/host_live_view.dart';
import '../rtmp_settings/rtmp_settings_view.dart';
import 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // ✅ Only render the active view — not all 4 at once
        body: _buildPage(controller.currentIndex.value),

        bottomNavigationBar: AppBottomNav(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const HostLiveView();
      case 2:
        return const AudienceLiveView();
      case 3:
        return const RtmpSettingsView();
      default:
        return const HomeView();
    }
  }
}

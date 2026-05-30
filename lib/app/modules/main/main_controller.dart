import 'package:get/get.dart';

import '../audience_live/audience_live_controller.dart';
import '../host_live/host_live_controller.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    final previous = currentIndex.value;

    // ✅ Clean up live controllers when leaving their tab
    if (previous == 1) {
      if (Get.isRegistered<HostLiveController>()) {
        Get.delete<HostLiveController>();
      }
    }
    if (previous == 2) {
      if (Get.isRegistered<AudienceLiveController>()) {
        Get.delete<AudienceLiveController>();
      }
    }

    currentIndex.value = index;

    // ✅ Re-create live controllers when entering their tab
    if (index == 1) {
      Get.put(HostLiveController());
    }
    if (index == 2) {
      Get.put(AudienceLiveController());
    }
  }
}

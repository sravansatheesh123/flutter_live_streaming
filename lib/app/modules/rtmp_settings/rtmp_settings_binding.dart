import 'package:get/get.dart';

import 'rtmp_settings_controller.dart';

class RtmpSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RtmpSettingsController>(
          () => RtmpSettingsController(),
    );
  }
}
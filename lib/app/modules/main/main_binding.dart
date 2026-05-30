import 'package:get/get.dart';
import '../home/home_controller.dart';
import '../host_live/host_live_controller.dart';
import '../audience_live/audience_live_controller.dart';
import '../rtmp_settings/rtmp_settings_controller.dart';
import '../main/main_controller.dart'; // ← add import

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController()); // ← add this
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HostLiveController>(() => HostLiveController());
    Get.lazyPut<AudienceLiveController>(() => AudienceLiveController());
    Get.lazyPut<RtmpSettingsController>(() => RtmpSettingsController());
  }
}

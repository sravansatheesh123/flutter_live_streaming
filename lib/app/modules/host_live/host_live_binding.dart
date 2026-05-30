// host_live_binding.dart
import 'package:get/get.dart';
import 'host_live_controller.dart';

class HostLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HostLiveController()); // ✅
  }
}

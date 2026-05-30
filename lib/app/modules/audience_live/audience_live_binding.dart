// audience_live_binding.dart
import 'package:get/get.dart';
import 'audience_live_controller.dart';

class AudienceLiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AudienceLiveController()); // ✅
  }
}

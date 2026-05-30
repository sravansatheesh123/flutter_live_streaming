import 'package:get/get.dart';

import '../data/services/storage_service.dart';
import '../data/services/agora_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService(), permanent: true);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RtmpSettingsController extends GetxController {
  final platformController = TextEditingController();

  final rtmpUrlController = TextEditingController();

  final streamKeyController = TextEditingController();

  final isSaved = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }

  Future<void> saveConfig() async {
    try {
      if (platformController.text.trim().isEmpty ||
          rtmpUrlController.text.trim().isEmpty ||
          streamKeyController.text.trim().isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        return;
      }

      if (!rtmpUrlController.text.trim().startsWith("rtmp")) {
        Get.snackbar("Error", "Invalid RTMP URL");
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('platform', platformController.text.trim());

      await prefs.setString('rtmp_url', rtmpUrlController.text.trim());

      await prefs.setString('stream_key', streamKeyController.text.trim());

      isSaved.value = true;

      Get.snackbar("Success", "RTMP Settings Saved");

      print("========== RTMP CONFIG ==========");
      print("Platform : ${platformController.text}");
      print("RTMP URL : ${rtmpUrlController.text}");
      print("Stream Key : ${streamKeyController.text}");
      print("FULL URL : $fullRtmpUrl");
      print("================================");
    } catch (e) {
      print("SAVE CONFIG ERROR => $e");

      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> loadConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      platformController.text = prefs.getString('platform') ?? '';

      rtmpUrlController.text = prefs.getString('rtmp_url') ?? '';

      streamKeyController.text = prefs.getString('stream_key') ?? '';

      isSaved.value =
          platformController.text.isNotEmpty &&
          rtmpUrlController.text.isNotEmpty &&
          streamKeyController.text.isNotEmpty;

      print("LOADED RTMP CONFIG");
      print("Platform : ${platformController.text}");
      print("RTMP URL : ${rtmpUrlController.text}");
      print("Stream Key : ${streamKeyController.text}");
    } catch (e) {
      print("LOAD CONFIG ERROR => $e");
    }
  }

  String get fullRtmpUrl {
    final url = rtmpUrlController.text.trim();

    final key = streamKeyController.text.trim();

    if (url.endsWith("/")) {
      return "$url$key";
    }

    return "$url/$key";
  }

  Future<void> clearConfig() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('platform');
    await prefs.remove('rtmp_url');
    await prefs.remove('stream_key');

    platformController.clear();
    rtmpUrlController.clear();
    streamKeyController.clear();

    isSaved.value = false;

    Get.snackbar("Success", "Configuration Cleared");
  }

  @override
  void onClose() {
    platformController.dispose();
    rtmpUrlController.dispose();
    streamKeyController.dispose();
    super.onClose();
  }
}

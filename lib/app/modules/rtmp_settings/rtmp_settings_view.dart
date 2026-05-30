import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rtmp_settings_controller.dart';

class RtmpSettingsView extends GetView<RtmpSettingsController> {
  const RtmpSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "RTMP Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              TextField(
                controller: controller.platformController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Platform Name",
                  labelStyle: const TextStyle(color: Colors.white70),
                  hintText: "YouTube / Facebook",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: controller.rtmpUrlController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "RTMP URL",
                  labelStyle: const TextStyle(color: Colors.white70),
                  hintText: "rtmp://a.rtmp.youtube.com/live2",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: controller.streamKeyController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Stream Key",
                  labelStyle: const TextStyle(color: Colors.white70),
                  hintText: "abcd-1234-xyz",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.saveConfig,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "SAVE SETTINGS",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (controller.isSaved.value)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff1A1D29),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Saved Configuration",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "Platform: ${controller.platformController.text}",
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "RTMP URL: ${controller.rtmpUrlController.text}",
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Stream Key: ${controller.streamKeyController.text}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

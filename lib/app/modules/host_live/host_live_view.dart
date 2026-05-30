import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'host_live_controller.dart';

class HostLiveView extends GetView<HostLiveController> {
  const HostLiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Host Live",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // ✅ Wait for engine to be ready before showing video
              if (!controller.isInitialized.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }

              // ✅ Engine ready — show camera preview always (uid 0 = local)
              return AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: controller.agoraService.engine,
                  canvas: const VideoCanvas(uid: 0),
                ),
              );
            }),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xff111827),
            child: Column(
              children: [
                Obx(
                  () => Text(
                    "Viewers : ${controller.viewerCount.value}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 10),

                Obx(
                  () => Text(
                    controller.liveStatus.value.name,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 10),

                Obx(
                  () => Text(
                    controller.rtmpStatus.value,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.startLive,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        child: const Text("START LIVE"),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.endLive,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        child: const Text("END LIVE"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

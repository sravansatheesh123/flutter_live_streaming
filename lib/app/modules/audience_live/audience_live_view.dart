import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_streaming/app/core/constants/app_constants.dart';
import 'package:get/get.dart';

import 'audience_live_controller.dart';

class AudienceLiveView extends GetView<AudienceLiveController> {
  const AudienceLiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Audience Live",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Obx(() {
        if (!controller.isJoined.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }

        if (controller.hostUid.value == 0) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.live_tv, color: Colors.white54, size: 80),
                SizedBox(height: 20),
                Text(
                  "Waiting for Host...",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: controller.agoraService.engine,
                  canvas: VideoCanvas(uid: controller.hostUid.value),
                  connection: const RtcConnection(
                    channelId: AppConstants.channelName,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "🔴 LIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

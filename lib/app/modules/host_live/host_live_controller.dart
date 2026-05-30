import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/enums/live_status.dart';
import '../../data/services/agora_service.dart';

class HostLiveController extends GetxController {
  late AgoraService agoraService;

  final liveStatus = LiveStatus.idle.obs;
  final viewerCount = 0.obs;
  final isLive = false.obs;
  final isInitialized = false.obs; // ✅ NEW
  final remoteUid = 0.obs;
  final rtmpStatus = ''.obs;

  String currentRtmpUrl = "";

  @override
  void onInit() {
    super.onInit();
    agoraService = AgoraService();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    await agoraService.initialize();

    agoraService.engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          print("HOST JOINED CHANNEL SUCCESS");
          liveStatus.value = LiveStatus.liveStarted;
          isLive.value = true;
        },

        onUserJoined: (connection, uid, elapsed) {
          print("VIEWER JOINED => $uid");
          viewerCount.value++;
          remoteUid.value = uid;
          print("TOTAL VIEWERS => ${viewerCount.value}");
        },

        onUserOffline: (connection, uid, reason) {
          print("VIEWER LEFT => $uid");
          if (viewerCount.value > 0) viewerCount.value--;
          if (uid == remoteUid.value) remoteUid.value = 0;
        },

        onConnectionStateChanged: (connection, state, reason) {
          print("HOST CONNECTION STATE => $state");
          print("HOST CONNECTION REASON => $reason");
        },

        onError: (err, msg) {
          print("HOST ERROR CODE => $err");
          print("HOST ERROR MESSAGE => $msg");
        },
      ),
    );

    isInitialized.value = true; // ✅ engine is ready now
    print("AGORA READY FOR HOST");
  }

  Future<void> startLive() async {
    try {
      liveStatus.value = LiveStatus.connecting;

      await agoraService.joinAsHost(); // ✅ no double initialize

      print("HOST JOIN REQUEST SENT");

      final prefs = await SharedPreferences.getInstance();
      final rtmpUrl = prefs.getString('rtmp_url') ?? '';
      final streamKey = prefs.getString('stream_key') ?? '';

      if (rtmpUrl.isNotEmpty && streamKey.isNotEmpty) {
        currentRtmpUrl = "$rtmpUrl/$streamKey";
        print("STARTING RTMP => $currentRtmpUrl");

        try {
          await agoraService.startRtmpPush(currentRtmpUrl);
          liveStatus.value = LiveStatus.crossLiveConnected;
          rtmpStatus.value = "Cross Live Connected";
          print("RTMP STARTED SUCCESSFULLY");
        } catch (e) {
          rtmpStatus.value = "Cross Live Failed (Stream still active)";
          print("RTMP FAILED => $e");
        }
      }
    } catch (e) {
      print("START LIVE ERROR => $e");
      isLive.value = false;
      liveStatus.value = LiveStatus.crossLiveFailed;
      rtmpStatus.value = "Live Start Failed";
    }
  }

  Future<void> endLive() async {
    try {
      if (currentRtmpUrl.isNotEmpty) {
        try {
          await agoraService.stopRtmpPush(currentRtmpUrl);
          print("RTMP STOPPED");
        } catch (e) {
          print("RTMP STOP ERROR => $e");
        }
      }

      await agoraService.leaveChannel();

      isLive.value = false;
      liveStatus.value = LiveStatus.ended;
      rtmpStatus.value = "Live Ended";
      print("LIVE ENDED");
    } catch (e) {
      print("END LIVE ERROR => $e");
    }
  }

  @override
  void onClose() {
    agoraService.dispose();
    super.onClose();
  }
}

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';

import '../../data/services/agora_service.dart';

class AudienceLiveController extends GetxController {
  late AgoraService agoraService;

  final hostUid = 0.obs;
  final isJoined = false.obs;

  bool _joining = false; // ✅ guard against double join

  @override
  void onInit() {
    super.onInit();
    agoraService = AgoraService();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    if (_joining) return; // ✅ prevent double call
    _joining = true;

    await agoraService.initialize();

    agoraService.engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          print("AUDIENCE JOIN SUCCESS");
          isJoined.value = true;
        },

        onUserJoined: (connection, uid, elapsed) {
          print("HOST FOUND via onUserJoined => $uid");
          hostUid.value = uid;
        },

        onRemoteVideoStateChanged: (connection, uid, state, reason, elapsed) {
          print("REMOTE VIDEO STATE => uid:$uid state:$state");

          if (state == RemoteVideoState.remoteVideoStateDecoding ||
              state == RemoteVideoState.remoteVideoStateStarting) {
            if (hostUid.value == 0) {
              print("HOST VIDEO ACTIVE => $uid");
              hostUid.value = uid;
            }
          }

          if (state == RemoteVideoState.remoteVideoStateStopped ||
              state == RemoteVideoState.remoteVideoStateFailed) {
            if (uid == hostUid.value) {
              print("HOST VIDEO STOPPED");
              hostUid.value = 0;
            }
          }
        },

        onUserOffline: (connection, uid, reason) {
          print("HOST WENT OFFLINE => $uid");
          if (uid == hostUid.value) hostUid.value = 0;
        },

        onError: (err, msg) {
          print("AUDIENCE ERROR CODE => $err");
          print("AUDIENCE ERROR MESSAGE => $msg");
        },
      ),
    );

    print("JOINING AS AUDIENCE...");
    await agoraService.joinAsAudience();
    print("AUDIENCE JOIN REQUEST SENT");
  }

  Future<void> leaveLive() async {
    await agoraService.leaveChannel();
  }

  @override
  void onClose() {
    leaveLive();
    super.onClose();
  }
}

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/constants/app_constants.dart';

class AgoraService {
  late RtcEngine engine;

  bool _initialized = false;

  Future<void> requestPermissions() async {
    await [Permission.camera, Permission.microphone].request();
  }

  Future<void> initialize() async {
    if (_initialized) return;

    await requestPermissions();

    engine = createAgoraRtcEngine();

    await engine.initialize(
      const RtcEngineContext(appId: AppConstants.agoraAppId),
    );

    await engine.enableVideo();

    await engine.enableAudio();

    await engine.setChannelProfile(
      ChannelProfileType.channelProfileLiveBroadcasting,
    );

    _initialized = true;

    print("AGORA INITIALIZED");
  }

  Future<void> joinAsHost() async {
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await engine.enableLocalVideo(true);

    await engine.enableLocalAudio(true);

    // ✅ REMOVED startPreview() — AgoraVideoView handles this automatically
    // Calling startPreview() causes BLASTBufferQueue buffer conflict

    await engine.joinChannel(
      token: "",
      channelId: AppConstants.channelName,
      uid: 1,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
      ),
    );

    print("HOST JOIN REQUEST SENT");
  }

  Future<void> joinAsAudience() async {
    await engine.setClientRole(role: ClientRoleType.clientRoleAudience);

    await engine.joinChannel(
      token: "",
      channelId: AppConstants.channelName,
      uid: 0,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
      ),
    );

    print("AUDIENCE JOIN REQUEST SENT");
  }

  Future<void> startRtmpPush(String rtmpUrl) async {
    print("RTMP PUSH START => $rtmpUrl");
    await engine.startRtmpStreamWithoutTranscoding(rtmpUrl);
  }

  Future<void> stopRtmpPush(String rtmpUrl) async {
    print("RTMP PUSH STOP => $rtmpUrl");
    await engine.stopRtmpStream(rtmpUrl);
  }

  Future<void> leaveChannel() async {
    await engine.leaveChannel();
    print("LEFT CHANNEL");
  }

  Future<void> dispose() async {
    await engine.release();
    _initialized = false;
    print("AGORA DISPOSED");
  }
}

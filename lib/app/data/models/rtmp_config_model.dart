class RtmpConfigModel {
  final String platformName;
  final String rtmpUrl;
  final String streamKey;

  const RtmpConfigModel({
    required this.platformName,
    required this.rtmpUrl,
    required this.streamKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'platformName': platformName,
      'rtmpUrl': rtmpUrl,
      'streamKey': streamKey,
    };
  }

  factory RtmpConfigModel.fromJson(
      Map<String, dynamic> json) {
    return RtmpConfigModel(
      platformName: json['platformName'] ?? '',
      rtmpUrl: json['rtmpUrl'] ?? '',
      streamKey: json['streamKey'] ?? '',
    );
  }
}
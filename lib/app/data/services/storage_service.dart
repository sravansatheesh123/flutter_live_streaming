import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/rtmp_config_model.dart';

class StorageService {
  static const String _rtmpKey = "rtmp_config";

  Future<void> saveConfig(
      RtmpConfigModel config) async {
    final pref =
    await SharedPreferences.getInstance();

    await pref.setString(
      _rtmpKey,
      jsonEncode(config.toJson()),
    );
  }

  Future<RtmpConfigModel?> getConfig() async {
    final pref =
    await SharedPreferences.getInstance();

    final data = pref.getString(_rtmpKey);

    if (data == null) return null;

    return RtmpConfigModel.fromJson(
      jsonDecode(data),
    );
  }

  Future<void> clear() async {
    final pref =
    await SharedPreferences.getInstance();

    await pref.remove(_rtmpKey);
  }
}
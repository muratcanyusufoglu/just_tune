import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class SharedManager {
  static SharedPreferences? _sharedPreferences;

  SharedManager() {
    if (_sharedPreferences == null) initInstances();
  }

  Future<void> initInstances() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setBool(String audioIndex, bool value) async {
    await _sharedPreferences!.setBool(audioIndex.toString(), value);
  }

  Future<bool> getBool(String audioName) async {
    bool isAudioSelect = _sharedPreferences!.getBool(audioName) ?? false;
    return isAudioSelect;
  }

  Future<bool> clearAll() async {
    return await _sharedPreferences!.clear();
  }
}

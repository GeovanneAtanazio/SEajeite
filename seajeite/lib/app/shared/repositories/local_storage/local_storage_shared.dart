import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:seajeite/app/shared/repositories/local_storage/local_storage_interface.dart';

class LocalStorageShared implements ILocalStorage {
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  LocalStorageShared() {
    _init();
  }

  Future<void> _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  @override
  Future<bool> delete(String key) async {
    var shared = await _instance.future;
    return shared.remove(key);
  }

  @override
  Future<String> getString(String key) async {
    var shared = await _instance.future;
    return shared.get(key);
  }

  @override
  Future<List<String>> getStringList(String key) async {
    var shared = await _instance.future;
    return shared.getStringList(key);
  }

  @override
  Future<bool> putString(String key, String value) async {
    var shared = await _instance.future;
    return shared.setString(key, value);
  }

  @override
  Future<bool> putStringList(String key, List<String> value) async {
    var shared = await _instance.future;
    return shared.setStringList(key, value);
  }
}

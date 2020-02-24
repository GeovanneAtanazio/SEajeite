import 'dart:convert';

import 'package:seajeite/app/shared/model/notification_model.dart';
import 'package:seajeite/app/shared/repositories/local_storage/local_storage_interface.dart';

class NotificationPreference {
  final ILocalStorage _storage;
  final String _prefKey = "notSetting";

  NotificationPreference(this._storage);

  Future<bool> setNotificationSettings(NotificationModel tuple) async {
    return await _storage.putString(_prefKey, json.encode(tuple.toJson()));
  }

  Future<NotificationModel> getNotificationSettings() async {
    var jsonPref = await _storage.getString(_prefKey);
    return jsonPref != null
        ? NotificationModel.fromJson(json.decode(jsonPref))
        : null;
  }

  Future<bool> deleteNotificationSettings() async {
    return await _storage.delete(_prefKey);
  }
}

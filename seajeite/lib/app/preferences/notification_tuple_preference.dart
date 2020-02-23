import 'dart:convert';
import 'package:seajeite/app/util/notification_setting_tuple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingTuplePreference {
  SharedPreferences prefs;
  final String _prefKey = "notSetting";

  Future<bool> setTuple(NotificationSettingTuple tuple) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString(_prefKey, json.encode(tuple.toJson()));
  }

  Future<NotificationSettingTuple> getNotificationSettingTuple() async {
    prefs = await SharedPreferences.getInstance();
    String jsonPref = prefs.getString(_prefKey) ?? null;
    return jsonPref != null
        ? NotificationSettingTuple.fromJson(json.decode(jsonPref))
        : null;
  }

  Future<Null> clear() async {
    prefs.remove(_prefKey);
  }
}

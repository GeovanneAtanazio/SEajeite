class NotificationSettingTuple {
  final int interval;
  final int qtdLimit;

  NotificationSettingTuple(this.interval, this.qtdLimit);

  NotificationSettingTuple.fromJson(Map<String, dynamic> json)
      : interval = json['interval'],
        qtdLimit = json['qtdLimit'];

  Map<String, dynamic> toJson() {
    return {"interval": interval, "qtdLimit": qtdLimit};
  }
}

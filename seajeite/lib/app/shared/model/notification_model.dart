class NotificationModel {
  int interval;
  int qtdLimit;

  NotificationModel(this.interval, this.qtdLimit);

  NotificationModel.fromJson(Map<String, dynamic> json)
      : interval = json['interval'],
        qtdLimit = json['qtdLimit'];

  Map<String, dynamic> toJson() {
    return {"interval": interval, "qtdLimit": qtdLimit};
  }
}

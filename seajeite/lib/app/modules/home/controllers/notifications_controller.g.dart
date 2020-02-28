// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationsController on _NotificationsControllerBase, Store {
  final _$intervalAtom = Atom(name: '_NotificationsControllerBase.interval');

  @override
  double get interval {
    _$intervalAtom.context.enforceReadPolicy(_$intervalAtom);
    _$intervalAtom.reportObserved();
    return super.interval;
  }

  @override
  set interval(double value) {
    _$intervalAtom.context.conditionallyRunInAction(() {
      super.interval = value;
      _$intervalAtom.reportChanged();
    }, _$intervalAtom, name: '${_$intervalAtom.name}_set');
  }

  final _$qtdLimitAtom = Atom(name: '_NotificationsControllerBase.qtdLimit');

  @override
  double get qtdLimit {
    _$qtdLimitAtom.context.enforceReadPolicy(_$qtdLimitAtom);
    _$qtdLimitAtom.reportObserved();
    return super.qtdLimit;
  }

  @override
  set qtdLimit(double value) {
    _$qtdLimitAtom.context.conditionallyRunInAction(() {
      super.qtdLimit = value;
      _$qtdLimitAtom.reportChanged();
    }, _$qtdLimitAtom, name: '${_$qtdLimitAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_NotificationsControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$getNotificationSettingAsyncAction =
      AsyncAction('getNotificationSetting');

  @override
  Future<void> getNotificationSetting() {
    return _$getNotificationSettingAsyncAction
        .run(() => super.getNotificationSetting());
  }

  final _$_NotificationsControllerBaseActionController =
      ActionController(name: '_NotificationsControllerBase');

  @override
  dynamic setInterval(double newInterval) {
    final _$actionInfo =
        _$_NotificationsControllerBaseActionController.startAction();
    try {
      return super.setInterval(newInterval);
    } finally {
      _$_NotificationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading() {
    final _$actionInfo =
        _$_NotificationsControllerBaseActionController.startAction();
    try {
      return super.setIsLoading();
    } finally {
      _$_NotificationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQtdLimit(double newTimes) {
    final _$actionInfo =
        _$_NotificationsControllerBaseActionController.startAction();
    try {
      return super.setQtdLimit(newTimes);
    } finally {
      _$_NotificationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'interval: ${interval.toString()},qtdLimit: ${qtdLimit.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}

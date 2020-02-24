// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$startTimeAtom = Atom(name: '_HomeControllerBase.startTime');

  @override
  DateTime get startTime {
    _$startTimeAtom.context.enforceReadPolicy(_$startTimeAtom);
    _$startTimeAtom.reportObserved();
    return super.startTime;
  }

  @override
  set startTime(DateTime value) {
    _$startTimeAtom.context.conditionallyRunInAction(() {
      super.startTime = value;
      _$startTimeAtom.reportChanged();
    }, _$startTimeAtom, name: '${_$startTimeAtom.name}_set');
  }

  final _$intervalAtom = Atom(name: '_HomeControllerBase.interval');

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

  final _$qtdLimitAtom = Atom(name: '_HomeControllerBase.qtdLimit');

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

  final _$getNotificationSettingAsyncAction =
      AsyncAction('getNotificationSetting');

  @override
  Future<void> getNotificationSetting() {
    return _$getNotificationSettingAsyncAction
        .run(() => super.getNotificationSetting());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic setInterval(double newInterval) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.setInterval(newInterval);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQtdLimit(double newTimes) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.setQtdLimit(newTimes);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic restartTime() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.restartTime();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'startTime: ${startTime.toString()},interval: ${interval.toString()},qtdLimit: ${qtdLimit.toString()}';
    return '{$string}';
  }
}

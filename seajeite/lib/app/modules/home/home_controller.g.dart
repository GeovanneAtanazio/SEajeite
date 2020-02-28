// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isNotifySetAtom = Atom(name: '_HomeControllerBase.isNotifySet');

  @override
  bool get isNotifySet {
    _$isNotifySetAtom.context.enforceReadPolicy(_$isNotifySetAtom);
    _$isNotifySetAtom.reportObserved();
    return super.isNotifySet;
  }

  @override
  set isNotifySet(bool value) {
    _$isNotifySetAtom.context.conditionallyRunInAction(() {
      super.isNotifySet = value;
      _$isNotifySetAtom.reportChanged();
    }, _$isNotifySetAtom, name: '${_$isNotifySetAtom.name}_set');
  }

  final _$getNotificationSettingAsyncAction =
      AsyncAction('getNotificationSetting');

  @override
  Future<NotificationModel> getNotificationSetting() {
    return _$getNotificationSettingAsyncAction
        .run(() => super.getNotificationSetting());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic setIsNotifySet(dynamic newIsNotifySet) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.setIsNotifySet(newIsNotifySet);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isNotifySet: ${isNotifySet.toString()}';
    return '{$string}';
  }
}

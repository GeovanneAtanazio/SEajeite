import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

abstract class DialogComponents {
  static showToast({
    @required String msg,
    @required bool isLengthShort,
    int timeInSecForIos,
    double fontSize,
    ToastGravity gravity,
    Color backgroundColor,
    Color textColor,
    Radius radius,
    double elevation,
  }) {
    FlutterFlexibleToast.showToast(
      message: msg,
      toastLength: isLengthShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      toastGravity: gravity ?? ToastGravity.BOTTOM,
      timeInSeconds: timeInSecForIos ?? 1,
      backgroundColor: backgroundColor ?? Colors.white,
      textColor: textColor ?? Colors.black,
      fontSize: fontSize ?? 16.0,
      radius: radius ?? 45,
      elevation: elevation ?? 10,
    );
  }
}

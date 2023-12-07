import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as la;

import 'logger.dart';

class Utils {
  static Size getTextSize(BuildContext context, {required String text, TextStyle? style, int maxLine = 1}) {
    return (TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: maxLine,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;
  }

  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      logger.d('Internet not connect');
    }
    return false;
  }

  static String parseDateToString(DateTime dateTime, String format, {String locale = "en"}) {
    String date = "";
    try {
      date = la.DateFormat(format, locale).format(dateTime);
    } on FormatException catch (e) {
      logger.e(e.toString());
    }
    return date;
  }

  static DateTime convertDateFromString(String strDate) => DateTime.parse(strDate);

  static DateTime convertDateFromTimeStamp(int timeStamp) => DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

  static Future pushAndRemoveUtilPage(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (Route<dynamic> route) => false);
  }

  static Future pushAndRemoveUtilKeepFirstPage(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), ModalRoute.withName(Navigator.defaultRouteName));
  }

  static void popToFirst(BuildContext context) {
    return Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
  }

  static void popByTime(BuildContext context, int count, {dynamic result}) {
    for (int i = 0; i < count - 1; i++) {
      Navigator.of(context).pop();
    }

    Navigator.of(context).pop(result);
  }

  static void popUtil(BuildContext context) {
    return Navigator.of(context).popUntil((Route<dynamic> route) => false);
  }

  static void popDialog(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  static Future rootNavigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => widget));
  }

  static void navigateNextFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) async {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static Future<bool> onWillPop() {
    DateTime? currentBackPressTime;
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "double tap to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  static void showErrorSnackBar(BuildContext context, String title) {
    final snackBar = SnackBar(
        content: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSnackBar(BuildContext context, String title) {
    final snackBar = SnackBar(
        content: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.green);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String convertVNtoText(String str) {
    str = str.replaceAll(RegExp(r'[à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ì|í|ị|ỉ|ĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳ|ý|ỵ|ỷ|ỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');
    str = str.replaceAll(RegExp(r'[À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ]'), 'A');
    str = str.replaceAll(RegExp(r'[È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ]'), 'E');
    str = str.replaceAll(RegExp(r'[Ì|Í|Ị|Ỉ|Ĩ]'), 'I');
    str = str.replaceAll(RegExp(r'[Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ]'), 'O');
    str = str.replaceAll(RegExp(r'[Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ]'), 'U');
    str = str.replaceAll(RegExp(r'[Ỳ|Ý|Ỵ|Ỷ|Ỹ]'), 'Y');
    str = str.replaceAll(RegExp(r'[Đ]'), 'D');
    return str;
  }

  static String numberCountWithLimit(int number, {int limit = 100}) => number > limit ? "+$limit" : "$number";
}

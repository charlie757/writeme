import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/signin.dart';
import 'constant.dart';

class Util {
  static Color loginBGColor() {
    return Colors.white;
  }

  static hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }

  static Positioned setTitle(String title) {
    return Positioned(
        top: 40,
        left: 0,
        right: 0,
        child: Container(
            height: 30,
            alignment: Alignment.center,
            child: Text(title.tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    // fontFamily: "Nexa",
                    fontWeight: FontWeight.w700))));
  }

  static Positioned setInnderHeader(String title, BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
            color: Constants.primaryThemeColor,
            // alignment: Alignment.center,
            height: 100,
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: Util.isNotch(context)
                        ? 42
                        : Platform.isIOS
                            ? 22
                            : 30,
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 40,
                        width: 40,
                        child: IconButton(
                            onPressed: () => {Navigator.pop(context)},
                            icon: new Image.asset(
                              'assets/images/back_arrow.png',
                            )))),
                Positioned(
                    left: 20,
                    right: 20,
                    top: Util.isNotch(context) ? 50 : 38,
                    child: Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(top: Util.isNotch(context) ? 12 : 0, right: 0),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                // fontFamily: "Nexa",
                                fontWeight: FontWeight.w700)))),
              ],
            )));
  }

  static Positioned setInnderTransparentHeader(
      String title, BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
            // color: Constants.secondaryThemeColor,
            alignment: Alignment.center,
            height: 100,
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: Util.isNotch(context)
                        ? 42
                        : Platform.isIOS
                            ? 15
                            : 24,
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 40,
                        width: 40,
                        child: IconButton(
                            onPressed: () => {Navigator.pop(context)},
                            icon: new Image.asset(
                              'assets/images/back.png',
                            )))),
                Positioned(
                    left: 50,
                    top: Util.isNotch(context)
                        ? 32
                        : Platform.isIOS
                            ? 13
                            : 23,
                    child: Container(
                        margin: EdgeInsets.only(
                            top: Util.isNotch(context) ? 12 : 2, left: 20),
                        height: 35,
                        width: 40,
                        child: new Image.asset(
                          'assets/images/plus_icon.png',
                        ))),
                Positioned(
                    left: 20,
                    right: 20,
                    top: Util.isNotch(context) ? 50 : 30,
                    child: Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.only(top: Util.isNotch(context) ? 12 : 0, right: 0),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                // fontFamily: "Nexa",
                                fontWeight: FontWeight.w700)))),
              ],
            )));
  }

  static Positioned setInnderHeaderWithRightBtn(
      String title, BuildContext context) {
    return Positioned(
        top: Util.isNotch(context) ? 10 : 0,
        left: 0,
        right: 20,
        child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 80,
                    width: 80,
                    child: IconButton(
                        onPressed: () => {Navigator.pop(context)},
                        icon: new Image.asset(
                          'assets/images/back.png',
                        ))),
                Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 50),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700)))),
                GestureDetector(
                    onTap: () => {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => AccountEdit()))
                          // Get.to(AccountEdit())
                        },
                    child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Text("edit".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700)),
                    )),
              ],
            )));
  }

  static showSuccessToast(String msg) {
    Get.snackbar('success'.tr, msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  static showErrorToast(String msg) {
    // Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );

    Get.snackbar('oops'.tr, msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }

  static Positioned setTopLogo() {
    return Positioned(
        top: 75,
        left: 0,
        right: 0,
        child: Container(
            height: 120,
            width: 200,
            alignment: Alignment.center,
            child: const Image(
              image: const AssetImage('assets/images/toplogo.png'),
              fit: BoxFit.cover,
            )));
  }

  static void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsLogin', false);

    Constants.token = "";

    Constants.userID = "";
    Constants.mobileNo = "";

    Util.saveIntValue("UserID", 0);

    Util.saveBooleanValue("IsLogin", false);
    Util.saveStringValue("Token", "");

    Util.saveStringValue("Name", "");
    Util.saveStringValue("Email", "");
    Util.saveStringValue("Mobile", "");
    Util.saveStringValue("UserPhoto", "");

    Get.offAll(() => SignIn());

    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => SignIn()), (
    //     Route<dynamic> route) => false);
  }

  static String checkNull(String? value) {
    if (value != null) {
      return value;
    }

    return "";
  }

  static isNotch(BuildContext context) {
    if (Platform.isAndroid) {
      return false;
    } else {
      final double statusBarHeight = MediaQuery.of(context).padding.top;

      return statusBarHeight >= 20 ? true : false;
    }
  }

  static Dio getDiaObject() {
    var dio = Dio(); // with default Options

// Set default configs
    dio.options.baseUrl = Constants.BASEURL;
    dio.options.connectTimeout = 50000; //5s
    dio.options.receiveTimeout = 30000;
    dio.options.headers = {
      HttpHeaders.userAgentHeader: 'dio',
      'common-header': 'xx',
      // "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
    };

    // Or you can create dio instance and config it as follow:
    //  var dio = Dio(BaseOptions(
    //    baseUrl: "http://www.dtworkroom.com/doris/1/2.0.0/",
    //    connectTimeout: 5000,
    //    receiveTimeout: 5000,
    //    headers: {
    //      HttpHeaders.userAgentHeader: 'dio',
    //      'common-header': 'xx',
    //    },
    //  ));
    dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // return handler.resolve( Response(data:"xxx"));
          // return handler.reject( DioError(message: "eh"));
          return handler.next(options);
        },
      ))
      ..add(LogInterceptor(responseBody: true)); //Open log;

    return dio;
  }

  static Future<bool> saveBooleanValue(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }

  static Future<bool> saveStringValue(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  static Future<bool> saveIntValue(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(key, value);
  }

  static Future<bool> getBooleanValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<String> getStringValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString(key));
    return prefs.getString(key) ?? "";
  }

  static Future<int> getIntValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    return prefs.getInt(key) ?? 0;
  }

  static tokenExpired(BuildContext context) {
    // Util.showSuccessToast("token_expired".tr);

    Future.delayed(Duration(seconds: 2), () {
      logout(context);
    });
  }

  static void showLoader() {
    EasyLoading.show(status: 'please_wait'.tr);
  }

  static bool isEnglishDefaultLan(String lang) {
    String locale = lang.toLowerCase();
    if (locale.contains("en")) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEnglishLan() {
    String lang = Get.locale.toString();

    String locale = lang.toLowerCase();
    if (locale.contains("en")) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkInernet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}

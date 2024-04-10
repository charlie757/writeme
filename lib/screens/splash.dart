import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'signin.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  String code = "";
  String appVersion = "";

  final tfCode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

// You can request multiple permissions at once.
    Timer(const Duration(seconds: 3), () => loginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          left: false,
          top: false,
          right: false,
          bottom: false,
          child: Stack(children: [
            getTopContainer(),
            getSplashImgView()
          ],)));
  }
  
  Widget getTopContainer(){
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
      width: Get.width,
      height: 300,
      color: Color.fromRGBO(148, 213, 241, 1.0),
    ));
  }

  Widget getSplashImgView(){
    return Positioned(
      top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
        width: Get.width,
        height: Get.height,
        child: Image.asset(
          'assets/images/splash.png',
          width: Get.width,
          height: Get.height,
          fit: BoxFit.contain,
        )));
  }

  void loginScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('IsLogin') ?? false;
    bool isLangDone = prefs.getBool('IsLangDone') ?? false;

    if (isLogin) {
      Get.off(() => Dashboard());
    } else {
      // if (isLangDone){
        Get.offAll(() => SignIn());
      // }else{
      //   Get.offAll(() => SelectLanguage());
      // }

      //
      // Get.off(() => SafetyInstructions());
      // Get.off(() => Home());
    }

    // Navigator.of(context).pushReplacement(new MaterialPageRoute(
    //     builder: (BuildContext context) => new SignIn()));
  }

  @override
  void dispose() {
    tfCode.dispose();
    super.dispose();
  }
}

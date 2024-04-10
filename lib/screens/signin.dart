import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../firehelper/Auth.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/pushnotificationsmanager.dart';
import '../utils/util.dart';
import 'verifyotp.dart';

bool isShowPassword = false;

final mobileNoTC = TextEditingController();

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return SignInState();
  }
}

class SignInState extends State<SignIn> with Observer {
  // String deviceToken = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Observable.instance.addObserver(this);
    PushNotificationsManager().init();
    getPermission();
  }

  getPermission() async {
    await [
      Permission.camera,
      Permission.location,
      Permission.mediaLibrary,
      Permission.photos,
      Permission.storage,
      Permission.audio,
      Permission.videos
    ].request();
  }

  @override
  update(Observable observable, String? notifyName, Map? map) {
    if (notifyName == "LoginSuccess") {
    } else {}
  }

  @override
  void dispose() {
    Observable.instance.removeObserver(this);

    mobileNoTC.text = "";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: false,
            body: new SafeArea(
                left: false,
                top: false,
                right: false,
                bottom: false,
                child: Stack(
                  children: [
                    getSplashImgView(),
                    getTopText(),
                  ],
                ))));
  }

  Widget getSplashImgView() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
            // width: Get.width,
            // height: Get.height,
            child: Image.asset(
          'assets/images/splash.png',
          // width: Get.width,
          // height: Get.height,
          fit: BoxFit.contain,
        )));
  }

  Positioned getTopText() {
    return Positioned(
        // top: Get.height-300,
        bottom: 50,
        left: 0,
        right: 0,
        child: Container(
            color: Colors.white,
            child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("welcome_back".tr,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    SizedBox(
                      height: 5,
                    ),
                    Text("enter_your_mobile_no_to_continue".tr,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                              fontWeight: FontWeight.normal,
                            )
                            .copyWith(color: Constants.secondaryThemeColor)),
                    SizedBox(
                      height: 30,
                    ),
                    LoginForm(),
                    getSigninBtn()
                  ],
                ))));
  }

  Container getSigninBtn() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();

              if (mobileNoTC.text.length == 0) {
                Util.showErrorToast("enter_mobileno".tr);
              } else {
                submitLoginData();
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Constants.primaryThemeColor),
              height: 50,
              child: Text(
                'continue'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            )));
  }

  submitLoginData() {
    sendSignUpDetailsOnServer().then((value) {
      print(value);
      EasyLoading.dismiss();
      parseData(value);
    });
  }

  loginOnFirebaseServer(var userDetails) async {
    String phoneNo = "+" + Constants.mobileNo.replaceAll("+", "");

    try {
      var authHandler = new Auth();
      authHandler.handleSignInWithPhoneNo(phoneNo, "");
    } catch (e) {
      print(e);
      // switch (e.code) {
      // case "user-not-found":
      //   registerOnServer();
      //   break;
      // }
    }
  }

  saveUserInfo(var user) {
    Constants.userID = user["id"].toString();

    Util.saveIntValue("UserID", user["id"]);
    Util.saveStringValue("Token", Constants.token);

    Util.saveStringValue("Name", Util.checkNull(user["name"]));
    Util.saveStringValue("Email", Util.checkNull(user["email"]));
    Util.saveStringValue("Mobile", Constants.mobileNo);
    Util.saveStringValue(
        "UserPhoto", Constants.IMGURL + Util.checkNull(user["profile_image"]));
  }

  Future<bool> parseData(String jsonStr) async {
    bool isSuccess = false;
    // {"status":1,"token":null,"otp":351037,"message":"message.You are successfully registered. Please check if you have entered your verification code that we sent to your phone."}
    var jsonValue = json.decode(jsonStr);

    if (jsonValue["status"] == 1) {
      isSuccess = true;

      // var str = mobileNoTC.text;
      Constants.mobileNo = mobileNoTC.text;

      // String errorMsg = jsonValue["otp"].toString();

      bool isRegister = false;

      if (jsonValue["register"] == 1) {
        isRegister = true;
      } else {
        isRegister = false;
      }

      Constants.token = Util.checkNull(jsonValue["token"]);

      var memberDetails = jsonValue["member_details"];
      saveUserInfo(memberDetails);

      loginOnFirebaseServer(memberDetails);

      // Util.showSuccessToast(errorMsg);
      // Util.showSuccessToast("otp_top_code_sent".tr);

      // Util.showSuccessToast(errorMsg);

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) =>
              VerifyOTP(isRegister: isRegister, userDetails: memberDetails),
        ),
      );
    } else {
      isSuccess = false;
      String errorMsg = jsonValue["message"];

      Util.showErrorToast(errorMsg);
    }

    return isSuccess;
  }

  Future<String> sendSignUpDetailsOnServer() async {
    String responseStr = "";

    var params = {
      "phone_no": mobileNoTC.text,
      "device_token": Constants.deviceToken,
      "device_type": Platform.isIOS ? "ios" : "android",
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.LOGINURL);

    await networkHelper.getServerResponse(params).then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }
}

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(left: 20, right: 20),
        height: 50.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(left: 10, right: 10, top: 5),
              height: 50,
              child: TextField(
                controller: mobileNoTC,
                keyboardType: TextInputType.phone,
                // maxLength: 10,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    // fontFamily: "Nexa",
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderSide: BorderSide(
                        color: Color.fromRGBO(149, 149, 149, 1), width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(149, 149, 149, 1), width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.only(left: 15, top: 5, right: 15),
                  hintText: 'mobile_number'.tr,
                  fillColor: Colors.white,
                  filled: true,
                  // color: Color.fromRGBO(189, 189, 189, 1.0),
                ),
              ),
            ),
          ],
        ));
  }
}

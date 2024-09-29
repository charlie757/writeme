import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sourcecode/screens/dashboard.dart';

import '../firehelper/Auth.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';
import 'signup.dart';

bool isShowPassword = false;

class VerifyOTP extends StatefulWidget {
  bool? isRegister = false;
  var userDetails = null;

  VerifyOTP({this.isRegister, this.userDetails});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return VerifyOTPState();
  }
}

class VerifyOTPState extends State<VerifyOTP> {
  TextEditingController textEditingController = TextEditingController();

  String errorMsg = "";
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: new Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              // backgroundColor: Constants.primaryThemeColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("verify_otp".tr, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)),
              centerTitle: true,
            ),
            body: new SafeArea(
              left: false,
              top: false,
              right: false,
              bottom: false,
              child: Column(
                children: [
                  getTopText(),
                  getFillOTPText(),
                  // SizedBox(height: 10,),
                  getOTPBox(),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  resendOTPText(),
                  getResentBtn(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ))),
    );
  }

  Widget getTopText() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Text('otp_top_code_sent'.tr,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Constants.secondaryThemeColor)),
    );
  }

  Widget getFillOTPText() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 70,
      ),
      child: Text('fill_the_otp'.tr,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,)),
    );
  }

  Widget getOTPBox() {
    return Container(
        height: 100,
        // width: MediaQuery.of(context).size.width - 50,
        alignment: Alignment.center,
        child: Form(
          key: formKey,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: PinCodeTextField(
                textStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                appContext: context,
                autoDismissKeyboard: false,
                autoFocus: true,
                pastedTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                obscuringCharacter: '*',
                obscuringWidget: null,
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  // if (v!.length < 3) {
                  //   return "I'm from validator";
                  // } else {
                  //   return null;
                  // }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  activeColor: Color.fromRGBO(244, 248, 252, 1.0),
                  selectedColor: Color.fromRGBO(239, 243, 246, 1.0),
                  inactiveColor: Color.fromRGBO(239, 243, 246, 1.0),
                  inactiveFillColor: Color.fromRGBO(239, 243, 246, 1.0),
                  activeFillColor: Constants.primaryThemeColor,
                  selectedFillColor: Color.fromRGBO(239, 243, 246, 1.0),
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: (MediaQuery.of(context).size.width - 50) / 6,
                ),
                cursorColor: Color.fromRGBO(213, 221, 224, 1.0),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                // errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,

                onCompleted: (v) {
                  print("Completed");
                  verifyOTP();
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return false;
                },
              )),
        ));
  }

  Widget resendOTPText() {
    return  Container(
            height: 50,
            alignment: Alignment.center,
            child:
                  Text(
                    'dont_get_code'.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal,).copyWith(color: Constants.secondaryThemeColor)),
                  );
  }

  Container getResentBtn() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();

              FocusScope.of(context).unfocus();

              resendOTP();
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Constants.primaryThemeColor),
              height: 50,
              child: Text(
                'resend'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            )));
  }

  saveUserInfo(var user) async {
    // Constants.token = Util.checkNull(user["token"]);

    Constants.userID = user["id"].toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', user["id"]);
    Util.saveIntValue("UserID", user["id"]);

    Util.saveBooleanValue("IsLogin", true);
    // Util.saveStringValue("Token", Constants.token);

    Util.saveStringValue("Name", Util.checkNull(user["name"]));
    Util.saveStringValue("Email", Util.checkNull(user["email"]));
    Util.saveStringValue("Mobile", Constants.mobileNo);
    Util.saveStringValue(
        "UserPhoto", Constants.IMGURL + Util.checkNull(user["profile_image"]));
  }

  verifyOTP() async {
    var authHandler = new Auth();
    User? user =
        await authHandler.verifyOTP(Constants.FirebaseVeriID, currentText);

    if (user != null) {
      if (widget.isRegister!) {
        Get.offAll(() => SignUp());
      } else {
        Util.saveBooleanValue("IsLogin", true);
        saveUserInfo(widget.userDetails);
        authHandler.saveUserDetails(user, widget.userDetails);
        Get.offAll(() => Dashboard());
      }
    }

    /*verifyOTPData().then((value) {
      print(value);

      parseData(value).then((isSuccess) {
        EasyLoading.dismiss();

        if (isSuccess) {
          // {"userStatus":"pending","status":1,"emailVerify":0,"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xMDMuOTMuMTcuMTQ2XC93cml0ZW1lXC9hcGlcL290cGxvZ2luIiwiaWF0IjoxNjU4ODIxNjYwLCJleHAiOjE2NTkxODE2NjAsIm5iZiI6MTY1ODgyMTY2MCwianRpIjoiRjYyYWlEVmVxQ0psaFRlUiIsInN1YiI6NywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.waDVSMZaJBVcGiHY89gBUTQrwxsf74Kk1H2DOi_Wrek","id":7,"name":null,"profile_image":null,"email":"","token_type":"bearer","expires_in":360000,"message":"Login successfully."}
          var jsonValue = json.decode(value);

          saveUserInfo(jsonValue);

          loginOnFirebaseServer(jsonValue);

          if(widget.isRegister!){
            Get.offAll( () => SignUp());
          }else{
            Get.offAll( () => Dashboard());
          }

        } else {
          setState(() {
            textEditingController.clear();
            currentText = "";
          });

        }
      });
    });*/
  }

  loginOnFirebaseServer(var userDetails) async {
    String phoneNo = "+91" + Constants.mobileNo;

    try {
      var authHandler = new Auth();
      authHandler.handleSignInWithPhoneNo(phoneNo, userDetails);
      /*.then((user) => {

        if (user != null){

          userData = FirebaseAuth.instance.currentUser!,
          print(userData.email),
          authHandler.updateUserData(
              userData, userDetails["name"], userDetails["profile_image"],
              Constants.deviceToken),
          Util.saveStringValue("FirebaseUID", userData.uid),
        }

      });*/
    } catch (e) {
      print(e);
      // switch (e.code) {
      //   case "user-not-found":
      //     registerOnServer();
      //     break;
      // }
    }
  }

  resendOTP() {
    textEditingController.clear();
    currentText = "";

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

    /*resentOTPOnServer().then((value) {
      print(value);

      EasyLoading.dismiss();
      resendParseData(value);
      textEditingController.clear();
      currentText = "";
    });*/
  }

  Future<bool> parseData(String jsonStr) async {
    bool isSuccess = false;

    var jsonValue = json.decode(jsonStr);

    if (jsonValue["status"] != 1) {
      isSuccess = false;
      String errorMsg = jsonValue["message"];
      Util.showErrorToast(errorMsg);
    } else {
      isSuccess = true;
    }

    return isSuccess;
  }

  Future<bool> resendParseData(String jsonStr) async {
    bool isSuccess = false;

    var jsonValue = json.decode(jsonStr);

    if (jsonValue["status"] != 1) {
      isSuccess = false;
      String errorMsg = jsonValue["message"];
      Util.showErrorToast(errorMsg);
    } else {
      isSuccess = true;

      String errorMsg = jsonValue["message"];
      Util.showSuccessToast(errorMsg);
    }

    return isSuccess;
  }

  Future<String> verifyOTPData() async {
    String responseStr = "";

    var params = {
      "phone_no": Constants.mobileNo,
      "otp": currentText,
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.OTPLOGIN);

    await networkHelper.getServerResponse(params).then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }

  Future<String> resentOTPOnServer() async {
    String responseStr = "";

    var params = {
      "phone_no": Constants.mobileNo,
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.RESENDOTP);

    await networkHelper.getServerResponse(params).then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }
}

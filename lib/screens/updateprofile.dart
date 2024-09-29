import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../firehelper/Auth.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return UpdateProfileState();
  }
}

class UpdateProfileState extends State<UpdateProfile> {
  bool isDataEdited = false;
  bool isFileSelected = false;

  String filePath = "";
  String base64Str = "";
  String serverImageURL = "";

  File? image;

  final nameTC = TextEditingController();
  final emailTC = TextEditingController();
  final phoneNoTC = TextEditingController();
  final messageTC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              // backgroundColor: Constants.primaryThemeColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("update_profile".tr, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)),
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                getUserProfileView(),
                getNameTextView(),
                // SizedBox(height: 10,),
                getEmailTextView(),
                getPhoneNoTextView(),
                // SizedBox(height: 10,),
                getMessageTextView(),
                getSigninBtn()
              ],
            )));
  }

  Column getUserProfileView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          margin: EdgeInsets.only(top: 50),
          height: 150,
          width: 150,
          child: Stack(children: [
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  child: serverImageURL.length > 0
                      ? CachedNetworkImage(
                          imageUrl:
                              serverImageURL, //"https://i.imgur.com/7PqjiH7.jpeg1"
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75)),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/profile_placeholder.png',
                            fit: BoxFit.fill,
                          ),
                        )
                      : (!isFileSelected
                          ? Container(
                              child: Image.asset(
                                'assets/images/profile_placeholder.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            )
                          : CircleAvatar(
                              radius: 75,
                              // backgroundColor: Color(0xffFDCF09),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: Image.file(
                                    image!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ))))),
            ),
            Positioned(
                top: 10,
                right: 18,
                child: GestureDetector(
                    onTap: () {
                      showOptionsDialog(context);
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: Image.asset(
                        'assets/images/pencil_icon.png',
                        fit: BoxFit.fill,
                      ),
                    ))),
          ])),
    ]);
  }

  Container getSigninBtn() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();

            if (isDataEdited) {
              submitData();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Constants.primaryThemeColor),
            height: 50,
            child: Text('submit'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                    )
                    .copyWith(color: Colors.black)),
          ),
        ));
  }

  Widget getNameTextView() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      height: 50.0,
      child: TextField(
        onChanged: (value) {
          isDataEdited = true;
        },
        controller: nameTC,
        // keyboardType: TextInputType.phone,
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            // fontFamily: "Nexa",
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            // borderSide: BorderSide.none,
            borderSide:
                BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: EdgeInsets.only(left: 15, top: 5, right: 15),
          hintText: 'name'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getEmailTextView() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
      height: 50.0,
      child: TextField(
        onChanged: (value) {
          isDataEdited = true;
        },
        controller: emailTC,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            // fontFamily: "Nexa",
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            // borderSide: BorderSide.none,
            borderSide:
                BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: EdgeInsets.only(left: 15, top: 5, right: 15),
          hintText: 'email'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getPhoneNoTextView() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
      height: 50.0,
      child: TextField(
        enabled: false,
        controller: phoneNoTC,
        keyboardType: TextInputType.phone,
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            // fontFamily: "Nexa",
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            // borderSide: BorderSide.none,
            borderSide:
                BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: EdgeInsets.only(left: 15, top: 5, right: 15),
          hintText: 'mobile_number'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getMessageTextView() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Color.fromRGBO(149, 149, 149, 1), width: 1)),
        height: 100.0,
        child: TextField(
          maxLines: 3,
          onChanged: (value) {
            isDataEdited = true;
          },
          controller: messageTC,
          style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              // fontFamily: "Nexa",
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            border: InputBorder.none,
            /*border: OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    borderSide: BorderSide(
                        color: Color.fromRGBO(149, 149, 149, 1), width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(149, 149, 149, 1), width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),*/
            contentPadding: EdgeInsets.only(left: 15, top: 5, right: 15),
            hintText: 'message'.tr,
            fillColor: Colors.white,
            filled: true,
            // color: Color.fromRGBO(189, 189, 189, 1.0),
          ),
        ));
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("choose_img_source".tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("camera".tr),
                    onTap: () {
                      Get.back();
                      openCamera();
                      // Get.to( () => CameraApp());
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("gallery".tr),
                    onTap: () {
                      Get.back();
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    final imgPicker = ImagePicker();

    final XFile? photo =
        await imgPicker.pickImage(source: ImageSource.camera, imageQuality: 30);

    setState(() {
      isFileSelected = true;
      isDataEdited = true;
      image = File(photo!.path);
      filePath = photo.path;
      serverImageURL = "";
    });

    List<int> imageBytes = image!.readAsBytesSync();
    base64Str = base64Encode(imageBytes);
  }

  void openGallery() async {
    final imgPicker = ImagePicker();

    final XFile? photo = await imgPicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);

    setState(() {
      isFileSelected = true;
      isDataEdited = true;
      image = File(photo!.path);
      filePath = photo.path;
      serverImageURL = "";
    });
    // Get.back();
    // Navigator.of(context, rootNavigator: true).pop();

    List<int> imageBytes = image!.readAsBytesSync();
    base64Str = base64Encode(imageBytes);
  }

  getUserDetails() {
    getUserDetailsFromServer().then((value) {
      print(value);

      EasyLoading.dismiss();

      var jsonValue = json.decode(value);

      if (jsonValue["status"] == 0) {
        String errorMsg = jsonValue["message"];
        Util.showErrorToast(errorMsg);
      } else {
        var response = jsonValue['member_details'];

        setState(() {
          nameTC.text = Util.checkNull(response['name']);
          emailTC.text = Util.checkNull(response['email']);
          phoneNoTC.text = Util.checkNull(response['phone_no']);
          messageTC.text = Util.checkNull(response['userinfomessage']);

          serverImageURL = Util.checkNull(response['profile_image']);

          // if  (isUpdaetOnFirebase){
          //   isUpdaetOnFirebase = false;
          //   // updateUserDetailsOnFirebase(Constants.IMGURL + serverImageURL, nameTC.text);
          //   updateUserDetailsOnFirebase(serverImageURL, nameTC.text);
          // }
        });
      }
    });
  }

  updateUserDetailsOnFirebase(String image, String name) {
    try {
      var authHandler = new Auth();
      var userData = FirebaseAuth.instance.currentUser!;
      print(userData.email);
      authHandler.updateUserData(userData, name, image, Constants.deviceToken);
    } catch (e) {
      print(e);
    }
  }

  submitData() {
    sendDetailsOnServer().then((value) {
      print(value);

      parseData(value).then((isSuccess) {
        EasyLoading.dismiss();

        if (isSuccess) {
          var jsonValue = json.decode(value);

          Util.showSuccessToast("profile_updated_successfully".tr);

          Util.saveStringValue("Name", nameTC.text);
          Util.saveStringValue("Email", emailTC.text);
          // Util.saveStringValue("UserPhoto", emailTC.text);

          var img = Util.checkNull(jsonValue['profile_image']);
          updateUserDetailsOnFirebase(img, nameTC.text);
        } else {
          EasyLoading.dismiss();
        }
      });
    });
  }

  Future<bool> parseData(String jsonStr) async {
    bool isSuccess = false;

    var jsonValue = json.decode(jsonStr);
    var response = jsonValue['response'];

    if (jsonValue["status"] == false) {
      isSuccess = false;
      String errorMsg = jsonValue["message"];
      Util.showErrorToast(errorMsg);

      if (response != null && response["is_verified"] != "1") {
        Constants.userID = response["user_id"].toString();
      }
    } else {
      isSuccess = true;
      // String errorMsg = jsonValue["message"];

      //   Navigator.of(context).push(
      //       PageRouteBuilder(
      //         opaque: false, // set to false
      //         pageBuilder: (_, __, ___) =>
      //             VerifyOTP(false, Util.checkNull(response['mobile']).isEmpty ? "" : Util.checkNull(response['email']),
      //                 Util.checkNull(response['mobile']).isNotEmpty ? Util.checkNull(response['mobile']) : ""),
      //       ),);
      // }
    }

    return isSuccess;
  }

  Future<String> sendDetailsOnServer() async {
    String responseStr = "";

    var params = {
      "name": nameTC.text,
      "email": emailTC.text,
      "userinfomessage": messageTC.text,
      "profileimage":
          base64Str.length == 0 ? "" : "data:image/jpeg;base64," + base64Str,
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.UPDATE_PROFILE);

    await networkHelper
        .getServerResponseWithHeader(params, Constants.token)
        .then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }

  Future<String> getUserDetailsFromServer() async {
    String responseStr = "";

    NetworkHelper networkHelper =
        NetworkHelper(Constants.GET_PROFILE + Constants.userID);

    await networkHelper.getServerResponseWithGET(Constants.token).then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }

  @override
  void dispose() {
    super.dispose();

    nameTC.text = "";
    emailTC.text = "";
    phoneNoTC.text = "";
    messageTC.text = "";
  }
}

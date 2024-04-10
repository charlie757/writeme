import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';


class ContactUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return ContactUsState();
  }
}

class ContactUsState extends State<ContactUs> {

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
              title: Text("contact_us".tr, style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)),
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                getNameTextView(),
                getPhoneNoTextView(),
                getEmailTextView(),
                // SizedBox(height: 10,),
                getMessageTextView(),
                getSubmitBtn()
              ],
            )));
  }

  Container getSubmitBtn() {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();

            if (nameTC.text.length == 0) {
              Util.showErrorToast("enter_name".tr);
            }else if (emailTC.text.length == 0) {
              Util.showErrorToast("enter_email".tr);
            }else if (phoneNoTC.text.length == 0) {
              Util.showErrorToast("enter_mobileno".tr);
            }else if (messageTC.text.length == 0) {
              Util.showErrorToast("enter_message".tr);
            }else{

              // nameTC.text = "";
              // emailTC.text = "";
              // phoneNoTC.text = "";
              // messageTC.text = "";

              submitData();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Constants.primaryThemeColor),
            height: 50,
            child: Text(
                'submit'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)),
          ),
        ));
  }

  Widget getNameTextView(){
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      height: 50.0,
      child: TextField(
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
          hintText: 'enter_name'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getEmailTextView(){
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
      height: 50.0,
      child: TextField(
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
          hintText: 'enter_email'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getPhoneNoTextView(){
    return Container(
      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
      height: 50.0,
      child: TextField(
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
          hintText: 'enter_mobileno'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getMessageTextView(){
    return Container(
        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(149, 149, 149, 1), width: 1)
        ),
        height: 100.0,
        child: TextField(
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

  submitData() {
    sendDetailsOnServer().then((value) {
      print(value);

      EasyLoading.dismiss();

        var jsonValue = json.decode(value);

        if (jsonValue["status"] == 1) {
          Util.showSuccessToast("contact_info_send_successfully".tr);

          nameTC.text = "";
          emailTC.text = "";
          phoneNoTC.text = "";
          messageTC.text = "";

        } else {
          var msg = jsonValue['message'];
          Util.showErrorToast(msg);
        }
    });
  }

  Future<String> sendDetailsOnServer() async {
    String responseStr = "";

    var params = {
      "name": nameTC.text,
      "email": emailTC.text,
      "phone_no": phoneNoTC.text,
      "message": messageTC.text,
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.CONTACT_US);

    await networkHelper.getServerResponseWithHeader(params, Constants.token).then((value) {
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


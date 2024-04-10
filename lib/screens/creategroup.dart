import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sourcecode/screens/contactlist.dart';

import '../firehelper/Auth.dart';
import '../firehelper/Database.dart';
import '../models/contactm.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';

// https://www.youtube.com/watch?v=t_sxlndzo1k

class CreateGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return CreateGroupState();
  }
}

class CreateGroupState extends State<CreateGroup> {
  bool isDataEdited = false;
  bool isFileSelected = false;
  bool isCreatingGroup = false;

  String filePath = "";
  String base64Str = "";
  String serverImageURL = "";

  File? image;

  List<ContactM> users = [];

  final nameTC = TextEditingController();

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
              title: Text("create_group".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                        fontWeight: FontWeight.bold,
                      )
                      .copyWith(color: Colors.black)),
            ),
            body: Column(
              children: [
                getUserProfileView(),
                getNameTextView(),
                // SizedBox(height: 10,),
                // SizedBox(height: 10,),
                getPeopleInGroupTextView(),
                getMenuItems(),
                getSigninBtn()
              ],
            ),
        bottomNavigationBar: isCreatingGroup ? Container(
          margin: EdgeInsets.all(10.0),
          height: MediaQuery
              .of(context)
              .size
              .height * 0.08,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(
                Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
            ),
          ),
        ) : Container(height: 0, width: 0,),));
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
                          imageUrl: Constants.IMGURL + serverImageURL,
                          //"https://i.imgur.com/7PqjiH7.jpeg1"
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
                            'assets/images/create_group.png',
                            fit: BoxFit.fill,
                          ),
                        )
                      : (!isFileSelected
                          ? Container(
                              child: Image.asset(
                                'assets/images/create_group.png',
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
                                    fit: BoxFit.fill,
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

            submitData();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Constants.primaryThemeColor),
            height: 50,
            child: Text('create_group'.tr,
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
            fontWeight: FontWeight.w500),
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
          hintText: 'enter_group_name'.tr,
          fillColor: Colors.white,
          filled: true,
          // color: Color.fromRGBO(189, 189, 189, 1.0),
        ),
      ),
    );
  }

  Widget getPeopleInGroupTextView() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 10,
        left: 30,
      ),
      height: 50.0,
      child: Text(
        "people_in_group".tr,
        style: TextStyle(
            color: Constants.secondaryThemeColor,
            fontSize: 15,
            // fontFamily: "Nexa",
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Container getMenuItems() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: width,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: users.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1),
          itemBuilder: (BuildContext context, int index) {
            // BannerM banner = menuItems[index];

            if (index == users.length) {
              return GestureDetector(
                  onTap: () async {
                    if (index == users.length) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactList(
                                isFromCreateGroup: false, isReturnUser: true)),
                      );

                      if (result != null) {
                        var isDuplicate = false;
                        for (ContactM user in users) {
                          if (user.id == result.id) {
                            isDuplicate = true;
                            break;
                          }
                        }
                        if (!isDuplicate) {
                          users.add(result);
                        }

                        setState(() {});
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Constants.primaryThemeColor,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Container(
                          margin: EdgeInsets.only(top: 7),
                          child: Image.asset(
                            'assets/images/plus.png',
                            fit: BoxFit.contain,
                          ),
                        )),
                  ));
            } else {
              var user = users[index];

              return GestureDetector(
                  onTap: () async {
                    if (index == users.length) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactList(
                                isFromCreateGroup: false, isReturnUser: true)),
                      );

                      if (result != null) {
                        users.add(result);

                        setState(() {});
                      }
                    }
                  },
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: user.profileImage.toString().isEmpty
                              ? Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'assets/images/user.png',
                                    fit: BoxFit.fill,
                                  ))
                              : CachedNetworkImage(
                                  imageUrl: Constants.IMGURL +
                                      user.profileImage.toString(),
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  imageBuilder: (context, image) => Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: image,
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          height: 60,
                                          width: 60,
                                          child: Image.asset(
                                            'assets/images/user.png',
                                            fit: BoxFit.fill,
                                          )))),
                      Positioned(
                          top: -5,
                          right: 5,
                          child: Container(
                              width: 45,
                              height: 45,
                              child: GestureDetector(
                                  onTap: () {
                                    users.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    'assets/images/cross_white.png',
                                    fit: BoxFit.fill,
                                  ))))
                    ],
                  ));
            }
          }),
    );
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
                      Navigator.pop(context);
                      openCamera();
                      // Get.to( () => CameraApp());
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("gallery".tr),
                    onTap: () {
                      Navigator.pop(context);
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
    });
    // Get.back();
    // Navigator.of(context, rootNavigator: true).pop();

    List<int> imageBytes = image!.readAsBytesSync();
    base64Str = base64Encode(imageBytes);
  }

  submitData() {
    if (nameTC.text.isEmpty) {
      Util.showErrorToast("enter_group_name".tr);
    } else if (base64Str.isEmpty) {
      Util.showErrorToast("select_group_image".tr);
    } else if (users.isEmpty) {
      Util.showErrorToast("select_group_members".tr);
    } else {

      if  (!isCreatingGroup) {
        createGroup();
      }

      setState(() {
        isCreatingGroup  = true;
      });

    }
  }

  createGroup() async {

    var members = [];
    for (ContactM user in users) {
      // members.add(user.uuid.toString() + '_' + user.name!);
      members.add(user.uuid.toString());
    }

    var userName = await Util.getStringValue("Name");

    // members.add(Constants.FirebaseUID + '_' + userName);
    members.add(Constants.FirebaseUID);

    var authHandler = new Auth();
    authHandler.createGroup(userName, Constants.FirebaseUID, nameTC.text, members).then((value) async {
      if (value.id != null) {
        String groupIcon = await getGroupImageUrl(value.id);

        await value.update({'groupIcon': groupIcon});

        Util.showSuccessToast("group_created_successfully".tr);

        Future.delayed(const Duration(milliseconds: 3000), () {

          setState(() {
            isCreatingGroup  = false;
          });

          setState(() {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });

        });
      }
    });

    EasyLoading.dismiss();
  }

  Future<String> getGroupImageUrl(String groupId) async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    String url = await dbHelper.uploadGroupIconImage(
      File(filePath),
      groupId,
    );
    return url;
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
    }

    return isSuccess;
  }

  Future<String> sendDetailsOnServer() async {
    String responseStr = "";

    var params = {
      "name": nameTC.text,
      "profileimage": "data:image/jpeg;base64," + base64Str,
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
  }
}

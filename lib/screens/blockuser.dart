import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sourcecode/firehelper/Database.dart';
import 'package:sourcecode/utils/baseappbar.dart';
import 'package:sourcecode/utils/constant.dart';
import 'package:sourcecode/utils/networkhelper.dart';
import 'package:sourcecode/utils/util.dart';

class BlockUser extends StatefulWidget {
  const BlockUser({super.key});

  @override
  State<BlockUser> createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUser> {
  @override
  void initState() {
    getBlockedUserList();
    super.initState();
  }

  List blockedUserList = [];
  late DatabaseHelper dbHelper;

  getFirebaseData(String id) async {
    FirebaseFirestore.instance
        .collection('chats')
        .where('id', isEqualTo: id)
        .where('currentUserToBlockId', isEqualTo: Constants.userID.toString())
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        var doc = value.docs[i];
        print(doc['currentUserToBlockId']);
        print(doc.data());
        print(doc.id);
        FirebaseFirestore.instance
            .collection('chats')
            .doc(doc.id)
            .collection('messages')
            .get()
            .then((subValue) {
          print("subss...${subValue.docs.length}");
          if (subValue.docs.isEmpty) {
            FirebaseFirestore.instance.collection('chats').doc(doc.id).delete();
          } else {
            FirebaseFirestore.instance
                .collection('chats')
                .doc(doc.id)
                .update({'block': false});
          }
        });
      }
      // print(value.docs.);
    });
  }

  @override
  Widget build(BuildContext context) {
    // getContactList();
    return Scaffold(
        appBar: BaseAppBar(title: Text("blockUser".tr), appBar: AppBar()),
        body: ListView.builder(
            itemCount: blockedUserList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  customDialogBox(
                      context: context,
                      id: blockedUserList[index]['id'].toString());
                },
                child: Container(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 60,
                                  child: blockedUserList[index]
                                              ['profile_image'] ==
                                          null
                                      ? Container(
                                          height: 60,
                                          width: 60,
                                          child: Image.asset(
                                            'assets/images/user.png',
                                            fit: BoxFit.fill,
                                          ))
                                      : CachedNetworkImage(
                                          imageUrl: Constants.IMGURL +
                                              blockedUserList[index]
                                                      ['profile_image']
                                                  .toString(),
                                          placeholder: (context, url) =>
                                              CupertinoActivityIndicator(),
                                          imageBuilder: (context, image) =>
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: image,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
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
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      Util.checkNull(
                                          blockedUserList[index]['name'] ?? ""),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          )
                                          .copyWith(color: Colors.black)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      Util.checkNull(blockedUserList[index]
                                              ['phone_no'] ??
                                          ''),
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                          )
                                          .copyWith(color: Colors.grey)),
                                ],
                              )
                            ]))),
              );
            }));
  }

  Future<void> customDialogBox(
      {required BuildContext context, required String id}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('confirmationOfUnBlockUser'.tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("yes".tr),
                    onTap: () {
                      EasyLoading.show();
                      sendUnBlockDetailsOnServer(id).then((value) async {
                        EasyLoading.dismiss();
                        Get.back();
                        getBlockedUserList();
                        getFirebaseData(id.toString());
                        var jsonData = json.decode(value);
                        if (jsonData['status'] == 1) {
                          Util.showSuccessToast(jsonData['message']);
                          setState(() {});
                        } else {
                          Util.showErrorToast(jsonData['message']);
                        }
                        print(value);
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("no".tr),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  getBlockedUserList() {
    getDataFromServer().then((value) {
      print(value);

      EasyLoading.dismiss();
      var jsonValue = json.decode(value);

      if (jsonValue["status"] != 1) {
        // String errorMsg = jsonValue["message"];
        // Util.showErrorToast(errorMsg);

        if (jsonValue["status"] == 0) {
          Util.tokenExpired(context);
        }
      } else {
        var user = jsonValue["users"];

        setState(() {
          blockedUserList = jsonValue['users'];
          // users = (user as List).map((i) => ContactM.fromJson(i)).toList();
        });
      }
    });
  }

  Future<String> getDataFromServer() async {
    String responseStr = "";

    var params = {};

    NetworkHelper networkHelper = NetworkHelper(Constants.GET_BLOCK_LIST);
    await networkHelper
        .getServerResponseWithHeader(params, Constants.token)
        .then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }

  Future<String> sendUnBlockDetailsOnServer(String id) async {
    String responseStr = "";
    // print("userId.....dvdf...$userId");
    // print("myId...$myId");
    var params = {
      'user_id': id,
    };
    NetworkHelper networkHelper = NetworkHelper(Constants.UNBLOCK_USER);
    await networkHelper
        .getServerResponseWithHeader(params, Constants.token)
        .then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }
}

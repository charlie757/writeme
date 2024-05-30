import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sourcecode/screens/creategroup.dart';

import '../firehelper/Database.dart';
import '../firehelper/chatDetailed.dart';
import '../models/contactm.dart';
import '../utils/baseappbar.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';

class ContactList extends StatefulWidget {
  bool? isFromCreateGroup = false;
  bool? isReturnUser = false;

  ContactList({Key? key, this.isFromCreateGroup, this.isReturnUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return ContactListState();
  }
}

class ContactListState extends State<ContactList> {
  List<ContactM> users = [];
  // List<SettingsM> originalusers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getContactList();

    // originalusers = List.from(users);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(title: Text("contacts".tr), appBar: AppBar()),
        body: getMenuList());
  }

  checkData() {
    for (int i = 0; i < users.length; i++) {
      print(users[i].status);
    }
  }

  Widget getMenuList() {
    // checkData();
    return
        // MediaQuery.removePadding(
        //   context: context,
        //   removeTop: true,
        //   child:
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemBuilder: (context, index) => (InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent, //
                  onTap: () {
                    if (widget.isFromCreateGroup! && index == 0) {
                      Get.to(() => CreateGroup());
                    } else {
                      if (widget.isReturnUser!) {
                        var contact = users[index];
                        Navigator.pop(context, contact);
                      } else {
                        var contact = users[index];
                        moveToChatScreen(
                            "+" + contact.phoneNo!, users[index].id);
                      }
                    }
                  },
                  child: getCellItem(index))),
              itemCount:
                  widget.isFromCreateGroup! ? users.length + 1 : users.length,
              shrinkWrap: true,
            ));
  }

  Container getCellItem(int idx) {
    if (widget.isFromCreateGroup! && idx == 0) {
      return getCreateGroupCell();
    } else {
      ContactM item = users[widget.isFromCreateGroup! ? idx - 1 : idx];

      return Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
              height: 60,
              margin: EdgeInsets.only(left: 5, right: 10),
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
                        child: item.profileImage.toString().isEmpty
                            ? Container(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                  'assets/images/user.png',
                                  fit: BoxFit.fill,
                                ))
                            : CachedNetworkImage(
                                imageUrl: Constants.IMGURL +
                                    item.profileImage.toString(),
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
                                errorWidget: (context, url, error) => Container(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      fit: BoxFit.fill,
                                    )))),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Util.checkNull(item.name),
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                                .copyWith(color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(Util.checkNull(item.phoneNo),
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
                  ])));
    }
  }

  Container getCreateGroupCell() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 5, right: 10),
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
                    child: Container(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/images/create_group.png',
                          fit: BoxFit.fill,
                        ))),
                SizedBox(
                  width: 15,
                ),
                Text("create_group".tr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                          fontWeight: FontWeight.bold,
                        )
                        .copyWith(color: Colors.black)),
              ],
            )));
  }

  moveToChatScreen(String phoneNo, id) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    QuerySnapshot doc = await dbHelper.getUserByEmail(phoneNo);

    if (doc.docs.length != 0) {
      DocumentSnapshot user = doc.docs[0];
      Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
      Util.getStringValue("FirebaseUID").then((value) {
        Get.to(() => ChatDetailed(id.toString(), userData, value))
            ?.then((value) {
          getContactList();
        });
      });
    }
  }

  getContactList() {
    getDataFromServer().then((value) {
      print(value);

      EasyLoading.dismiss();
      var jsonValue = json.decode(value);

      if (jsonValue["status"] != 1) {
        String errorMsg = jsonValue["message"];
        Util.showErrorToast(errorMsg);

        if (jsonValue["status"] == 0) {
          Util.tokenExpired(context);
        }
      } else {
        var user = jsonValue["users"];

        setState(() {
          users = (user as List).map((i) => ContactM.fromJson(i)).toList();
        });
      }
    });
  }

  Future<String> getDataFromServer() async {
    String responseStr = "";

    var params = {};

    NetworkHelper networkHelper = NetworkHelper(Constants.GER_USER_LIST);

    await networkHelper
        .getServerResponseWithHeader(params, Constants.token)
        .then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }
}

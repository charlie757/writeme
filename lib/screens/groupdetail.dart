import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sourcecode/firehelper/Auth.dart';
import '../firehelper/Database.dart';
import '../utils/baseappbar.dart';
import '../utils/constant.dart';
import '../utils/util.dart';

class GroupDetail extends StatefulWidget {
  String groupId = "";
  String groupName = "";

  GroupDetail({this.groupId = "", this.groupName = ""});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return GroupDetailState();
  }
}

class GroupDetailState extends State<GroupDetail> {

  var isGroupOwnwer = false;
  var isFileSelected = false;

  File? image;

  String groupImageURL = "";
  List<String> members = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getGroupDetail();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(title: Text(widget.groupName), appBar: AppBar()),
        body: ListView(
          children: [
            GestureDetector(onTap: () {
              showOptionsDialog(context);
            }, child: getUserProfileView()),
            getGroupNameTextView(),
            getPeopleLbl(),
            Column(
              children: getPeopleList(),
            ),
            getExitGroup()
          ],
        ));
  }

  getGroupDetail() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    QuerySnapshot doc = await dbHelper.getGroupDetails(widget.groupId);

    if (doc.docs.length != 0) {
      DocumentSnapshot user = doc.docs[0];
      Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
      groupImageURL = userData['groupIcon'];
      members = userData['members'].cast<String>();

      if (Constants.FirebaseUID == userData['adminId']){
        isGroupOwnwer = true;
      }

      setState(() {});
    }
  }

  Container getUserProfileView() {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        child: Container(
            height: 150,
            width: 150,
            alignment: Alignment.center,
            child: isFileSelected ? CircleAvatar(
                radius: 75,
                // backgroundColor: Color(0xffFDCF09),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.file(
                      image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ))) : CachedNetworkImage(
              imageUrl: groupImageURL,
              //"https://i.imgur.com/7PqjiH7.jpeg1"
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(75)),
                ),
              ),
              placeholder: (context, url) => CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/create_group.png',
                fit: BoxFit.fill,
              ),
            )));
  }

  Widget getGroupNameTextView() {
    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.only(top:10,),
      height: 50.0,
      child: Text(widget.groupName,
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(
                fontWeight: FontWeight.bold,
              )
              .copyWith(color: Colors.black)),
    );
  }

  Container getPeopleLbl() {
    var memberCount = members != null ? members.length : 0;

    return Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      height: 50.0,
      child: Text("$memberCount People",
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(
                fontWeight: FontWeight.bold,
              )
              .copyWith(color: Colors.black)),
    );
  }

  List<Widget> getPeopleList() {
    late DatabaseHelper dbHelper = new DatabaseHelper();

    if (members != null) {
      List<Widget> children = [];

      for (String id in members) {
        children.add(Container(
          child: FutureBuilder(
            future: dbHelper.getUserByUsername(id),
            builder: (context, _snapshot) {
              if (_snapshot.hasData &&
                  (_snapshot.data! as DocumentSnapshot).data() != null) {
                DocumentSnapshot doc = _snapshot.data! as DocumentSnapshot;
                Map<String, dynamic> _user = doc.data() as Map<String, dynamic>;
                return Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30),
                  height: 50,
                  child: Row(
                    children: [
                      _user["photo"].toString().isEmpty
                          ? Container(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'assets/images/user.png',
                                fit: BoxFit.fill,
                              ))
                          : CachedNetworkImage(
                              imageUrl: _user['photo'].toString(),
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              imageBuilder: (context, image) => Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: image,
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: CupertinoActivityIndicator()),
                            ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        id == Constants.FirebaseUID
                            ? _user['name'].toString() + "(Group Admin)"
                            : _user['name'].toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: id == Constants.FirebaseUID
                              ? FontWeight.w800
                              : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  // margin: EdgeInsets.all(10.0),
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
      }

      return children;
    }
    return [];
  }

  Container getExitGroup() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30.0, right: 30),
      height: 50,
      child: InkWell(onTap: (){

        isGroupOwnwer ? deleteGroupDialog() : showExitDialog();

      }, child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(243, 164, 152, 1.0), 
              borderRadius: BorderRadius.circular(20)
            ),
            height: 40,
            width: 40,
            child: Image.asset(
              'assets/images/exit_group.png',
              fit: BoxFit.contain,
              height: 20,
              width: 20,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            isGroupOwnwer ? 'delete_group'.tr : "exit_group".tr,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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

    final XFile? photo = await imgPicker.pickImage(source: ImageSource.camera, imageQuality: 30);

    setState(() {
      isFileSelected = true;
      image = File(photo!.path);
    });

    Util.showLoader();

    String filePath = photo!.path;

    String groupIcon = await getGroupImageUrl(widget.groupId, filePath);

    Auth().updateGroupImg(groupIcon, widget.groupId).then((value) {

      EasyLoading.dismiss();

      Util.showSuccessToast("group_created_successfully".tr);

      Observable.instance.notifyObservers(["GroupChatListingState",], notifyName : "GroupUpdated",map: null);
      Observable.instance.notifyObservers(["GroupChatDetailedState",], notifyName : "GroupUpdated",map: null);

    });

  }

  void openGallery() async {
    final imgPicker = ImagePicker();

    final XFile? photo = await imgPicker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    setState(() {
      isFileSelected = true;
      image = File(photo!.path);
    });
    // Get.back();
    // Navigator.of(context, rootNavigator: true).pop();

    Util.showLoader();

    String filePath = photo!.path;

    String groupIcon = await getGroupImageUrl(widget.groupId, filePath);

    Auth().updateGroupImg(groupIcon, widget.groupId).then((value) {

      EasyLoading.dismiss();

    Util.showSuccessToast("group_created_successfully".tr);

    Observable.instance.notifyObservers(["GroupChatListingState",], notifyName : "GroupUpdated",map: null);
    Observable.instance.notifyObservers(["GroupChatDetailedState",], notifyName : "GroupUpdated",map: null);

    });


  }

  Future<String> getGroupImageUrl(String groupId, String filePath) async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    String url = await dbHelper.uploadGroupIconImage(
      File(filePath),
      groupId,
    );
    return url;
  }


  Future<void> showExitDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("are_you_sure".tr  + "do_wanna_exit_group".tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("yes".tr),
                    onTap: () {
                      Navigator.pop(context);

                      removeUserFromGroup();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
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

  Future<void> deleteGroupDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("are_you_sure".tr  + "do_wanna_delete_group".tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("yes".tr),
                    onTap: () {
                      Navigator.pop(context);

                      deleteGroup();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
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

  removeUserFromGroup()async{

    List<String> newMem = [];

    for (String str in members){

      if (str != Constants.FirebaseUID) {
        newMem.add(str);
      }
    }

    FirebaseFirestore tempDb = FirebaseFirestore.instance;
    await tempDb
        .collection('groups')
        .doc(widget.groupId)
        .update({'members': newMem});

      Util.showSuccessToast("removed_from_group".tr);

    Future.delayed(const Duration(milliseconds: 3000), () {

      setState(() {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });

    });

  }

  deleteGroup()async{

    List<String> newMem = [];

    for (String str in members){
      newMem.add(str);
    }

    FirebaseFirestore tempDb = FirebaseFirestore.instance;
    await tempDb
        .collection('groups')
        .doc(widget.groupId)
        .delete();

    Util.showSuccessToast("group_deleted_successfully".tr);

    Future.delayed(const Duration(milliseconds: 3000), () {

      setState(() {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });

    });

  }
}

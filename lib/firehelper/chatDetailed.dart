import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
// import 'package:video_thumbnail/video_thumbnail.dart';

import '../screens/commonwebview.dart';
import '../screens/customvideoplayer.dart';
import '../screens/webviewdoc.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';
import 'Database.dart';
import 'OfflineStore.dart';
import 'imageViewer.dart';

// https://stackoverflow.com/questions/64764111/undefined-class-storagereference-when-using-firebase-storage

class ChatDetailed extends StatefulWidget {
  String currentUserFireId = "";
  Map<String, dynamic> userData;

  ChatDetailed(this.userData, this.currentUserFireId);

  @override
  _ChatDetailedState createState() => _ChatDetailedState();
}

class _ChatDetailedState extends State<ChatDetailed> {
  late String myId, userId;
  String? selectedReportType;
  final reportMessageController = TextEditingController();
  late TextEditingController messageController;
  Timestamp past = new Timestamp.fromDate(new DateTime(2019));
  late DatabaseHelper dbHelper;
  late String chatId;
  late OfflineStorage offlineStorage;
  late Map<String, dynamic> userData;
  final _scaffKey = GlobalKey<ScaffoldState>();

  final ImagePicker _picker = ImagePicker();

  Color userColor = Color.fromRGBO(236, 240, 244, 1.0);
  Color oppoColor = Color.fromRGBO(119, 0, 174, 1.0);

  List<String> reportTypeList = ['Block', 'Other'];

  @override
  void initState() {
    super.initState();
    messageController = new TextEditingController();
    dbHelper = new DatabaseHelper();
    offlineStorage = new OfflineStorage();
    userId = widget.userData['uid'].toString();
    userData = widget.userData;
    myId = widget.currentUserFireId;
    offlineStorage.getUserInfo().then(
      (val) {
        setState(
          () {
            Map<dynamic, dynamic> user = val;
            userId = widget.userData['uid'].toString();
            myId = user['uid'].toString();
            chatId = dbHelper.generateChatId(
              myId,
              userId,
            );
            userData = widget.userData;
            Constants.openChatId = chatId;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("userId....$userId");
    return Scaffold(
      key: _scaffKey,
      backgroundColor: const Color.fromRGBO(137, 207, 240, 1.0),
      body: Column(
        children: [
          AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: const Color.fromRGBO(137, 207, 240, 1.0),
            title: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userData["photo"].toString().isEmpty
                      ? Container(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            'assets/images/user.png',
                            fit: BoxFit.fill,
                          ))
                      : GestureDetector(
                          onTap: (() => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageViewer(
                                          // snapshot.data.toString(),
                                          userData['photo'].toString()),
                                    ))
                              }),
                          child: CachedNetworkImage(
                            imageUrl: userData['photo'].toString(),
                            placeholder: (context, url) =>
                                CupertinoActivityIndicator(),
                            imageBuilder: (context, image) => Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: image,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: CupertinoActivityIndicator()),
                          )),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Expanded(
                    child: Text(userData['name'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  PopupMenuButton(itemBuilder: (
                    contextx,
                  ) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          showReportSheet();
                        },
                        child: Text("report".tr),
                        value: '/hello',
                      ),
                    ];
                  })
                ],
              ),
            ),
          ),
          Flexible(
            child: _chatBody(userId),
          ),
          const Divider(
            height: 1.0,
          ),
          SizedBox(
            height: 70, //MediaQuery.of(context).size.height * 0.10,
            child: Container(color: userColor, child: _messageComposer()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Constants.openChatId = "";
    super.dispose();
  }

  Widget _messageComposer() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // showOptionsDialog(context);
              showOptionSheet();
            },
            child: Icon(
              Icons.image,
              color: Constants.primaryThemeColor,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: messageController,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 0),
                border: new OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.primaryThemeColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.primaryThemeColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.primaryThemeColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                errorBorder: new OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constants.primaryThemeColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: false,
                hintText: "type_a_message".tr,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: FloatingActionButton(
            backgroundColor: Constants.primaryThemeColor,
            onPressed: () async {
              String message = messageController.text;
              if (message.isNotEmpty) {
                messageController.clear();
                sentNotification(message);
                await dbHelper.sendMessage(userId, myId, true, message, "", "");
              }
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  showOptionSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 280,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Get.back();
                        openCamera("photo");
                      },
                      child: Container(
                          height: 40, child: Text('take_photo_camera'.tr))),
                  InkWell(
                      onTap: () {
                        Get.back();
                        openGallery("photo");
                      },
                      child: Container(
                          height: 40, child: Text('take_photo_gallery'.tr))),
                  InkWell(
                      onTap: () {
                        Get.back();
                        openCamera("video");
                      },
                      child: Container(
                          height: 40, child: Text('take_video_camera'.tr))),
                  InkWell(
                      onTap: () {
                        Get.back();
                        openGallery("video");
                      },
                      child: Container(
                          height: 40, child: Text('take_vidoe_gallery'.tr))),
                  InkWell(
                      onTap: () {
                        Get.back();
                        openDocFiles();
                        // Future.delayed(Duration(seconds: 2), () {

                        // });
                      },
                      child: Container(height: 40, child: Text('doc'.tr))),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(height: 40, child: Text('cancel'.tr))),
                ],
              ),
            ),
          );
        });
  }

  showReportSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 25, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'report'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Constants.primaryThemeColor, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconEnabledColor: Constants.primaryThemeColor,
                          padding: const EdgeInsets.only(left: 15, right: 0),
                          value: selectedReportType,
                          hint: const Text('Select report type'),
                          items: reportTypeList.map((String value) {
                            return DropdownMenuItem<String>(
                              enabled: true,
                              value: value,
                              child: Text(
                                value.toString(),
                                style: const TextStyle(),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            print(val);
                            selectedReportType = val;
                            state(() {});
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    messageTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    getSubmitBtn()
                  ],
                ),
              ),
            );
          });
        });
  }

  messageTextField() {
    return TextFormField(
      maxLines: 3,
      controller: reportMessageController,
      decoration: InputDecoration(
          hintText: 'Enter your reason here...',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Constants.primaryThemeColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Constants.primaryThemeColor,
              ))),
    );
  }

  Container getSubmitBtn() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: GestureDetector(
            onTap: () async {
              if (selectedReportType != null &&
                  reportMessageController.text.isNotEmpty) {
                FocusScope.of(context).unfocus();
                EasyLoading.show();
                sendReportDetailsOnServer().then((value) {
                  EasyLoading.dismiss();
                  var jsonData = json.decode(value);
                  if (jsonData['status'] == 1) {
                    Get.back();
                    Util.showSuccessToast(jsonData['message']);
                    reportMessageController.clear();
                    selectedReportType = null;
                    setState(() {});
                  } else {
                    Util.showErrorToast(jsonData['message']);
                  }
                  print(value);
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Constants.primaryThemeColor),
              height: 50,
              child: Text(
                'submit'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            )));
  }

  getPermission() async {
    await [
      Permission.photos,
      Permission.storage,
      //Permission.manageExternalStorage
    ].request();
  }

  openDocFiles() async {
    getPermission();

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        withData: true,
        // allowedExtensions: ['pdf', 'doc', 'docx', "xls"],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        if (file.extension!.contains("pdf") ||
            file.extension!.contains("doc") ||
            file.extension!.contains("docx") ||
            file.extension!.contains("xls")) {
          if (isBigFile(File(file.path!))) {
            Util.showErrorToast("big_file_size".tr);
          } else {
            uploadImage(File(file.path!));
          }
        } else {
          Util.showErrorToast("File type should be doc, docx, pdf, xls");
        }

        print(file.name);
        print(file.bytes);
        print(file.size);
        print(file.extension);
        print(file.path);
      } else {
        // User canceled the picker
        Util.showErrorToast(result.toString() + "");
      }
    } on PlatformException catch (e) {
      Util.showErrorToast('Platform Unsupported operation' + e.toString());
    } catch (e) {
      Util.showErrorToast('Unsupported operation' + e.toString());
    }
  }

  StreamBuilder<QuerySnapshot> _chatBody(String userId) {
    return StreamBuilder(
      stream: dbHelper.getChat(userId, myId),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return snapshot.data!.docs.length != 0
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot messageData = snapshot.data!.docs[index];
                    Map<String, dynamic> message =
                        messageData.data() as Map<String, dynamic>;
                    if (snapshot.data!.docs.length == 1)
                      return Column(
                        children: [
                          // _timeDivider(message.data()!['time']),
                          _timeDivider(message['time']),
                          _messageItem(messageData, context),
                        ],
                      );
                    if (index == 0) {
                      // past = message.data()['time'];
                      past = message['time'];
                      return _messageItem(messageData, context);
                    }
                    Timestamp toPass = past;
                    if (index == snapshot.data!.docs.length - 1)
                      return Column(
                        children: [
                          // _timeDivider(message.data()['time']),
                          _timeDivider(message['time']),
                          _messageItem(messageData, context),
                          // if (!sameDay(toPass, message.data()['time']))
                          if (!sameDay(toPass, message['time']))
                            _timeDivider(toPass),
                        ],
                      );
                    // past = message.data()['time'];
                    // past = message.data()['time'];
                    return sameDay(message['time'], toPass)
                        ? _messageItem(messageData, context)
                        : Column(
                            children: [
                              _messageItem(messageData, context),
                              _timeDivider(toPass),
                            ],
                          );
                  },
                )
              : Center(child: Text("no_message_yet".tr));
        return Center(
          child: Text('Loading...'),
        );
      },
    );
  }

  Widget _timeDivider(Timestamp time) {
    DateTime t = time.toDate();
    return Text(t.day.toString() +
        ' ' +
        Constants.months.elementAt(t.month - 1) +
        ', ' +
        t.year.toString());
  }

  bool sameDay(Timestamp present, Timestamp passt) {
    DateTime pastTime = passt.toDate();
    DateTime presentTime = present.toDate();
    if (pastTime.year < presentTime.year) return false;
    if (pastTime.month < presentTime.month) return false;
    return pastTime.day == presentTime.day;
  }

  _messageItem(DocumentSnapshot messageData, BuildContext context) {
    Map<String, dynamic> message = messageData.data() as Map<String, dynamic>;

    final bool isMe = message['from'] == myId;
    // Timestamp time = message.data()['time'];
    Timestamp time = message['time'];
    DateTime ttime = time.toDate();
    String minute = ttime.minute > 9
        ? ttime.minute.toString()
        : '0' + ttime.minute.toString();
    String ampm = ttime.hour >= 12 ? "PM" : "AM";
    int hour = ttime.hour >= 12 ? ttime.hour % 12 : ttime.hour;
    // if (message.data()['isText'])
    if (message['isText'])
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          margin: isMe
              ? EdgeInsets.only(
                  left: 80.0,
                  bottom: 8.0,
                  top: 8.0,
                )
              : EdgeInsets.only(
                  right: 80.0,
                  bottom: 8.0,
                  top: 8.0,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hour.toString() + ":" + minute.toString() + " " + ampm,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                // message.data()['message'].toString(),
                message['message'].toString(),
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: isMe ? userColor : oppoColor,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
        ),
      );
    else if (message['type'] == "image") {
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 160,
          width: 200,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          margin: isMe
              ? EdgeInsets.only(
                  left: 80.0,
                  bottom: 8.0,
                  top: 8.0,
                )
              : EdgeInsets.only(
                  right: 80.0,
                  bottom: 8.0,
                  top: 8.0,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hour.toString() + ":" + minute.toString() + " " + ampm,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(height: 5),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewer(
                        // snapshot.data.toString(),
                        message['photo'].toString()),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: message['photo'].toString(),
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  imageBuilder: (context, image) => Container(
                    height: 110,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    )),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: CupertinoActivityIndicator()),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: isMe ? userColor : oppoColor,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
        ),
      );
    } else if (message['type'] == "video") {
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 160,
          width: 200,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          margin: isMe
              ? EdgeInsets.only(
                  left: 80.0,
                  bottom: 8.0,
                  top: 8.0,
                )
              : EdgeInsets.only(
                  right: 80.0,
                  bottom: 8.0,
                  top: 8.0,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hour.toString() + ":" + minute.toString() + " " + ampm,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(height: 5),
              InkWell(
                onTap: () => {
                  if (message['videoUrl'] != null)
                    {
                      Get.to(() =>
                          CustomVideoPlayer(message['videoUrl'].toString()))
                    }
                },
                child: CachedNetworkImage(
                  imageUrl: message['photo'].toString(),
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  imageBuilder: (context, image) => Container(
                    height: 110,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                        child: Image.asset(
                      'assets/images/play.png',
                      fit: BoxFit.fill,
                      width: 30,
                      height: 30,
                    )),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: CupertinoActivityIndicator()),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: isMe ? userColor : oppoColor,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: 155,
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: isMe
            ? EdgeInsets.only(
                left: 80.0,
                bottom: 8.0,
                top: 8.0,
              )
            : EdgeInsets.only(
                right: 80.0,
                bottom: 8.0,
                top: 8.0,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hour.toString() + ":" + minute.toString() + " " + ampm,
              style: TextStyle(
                color: isMe ? Colors.black : Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(height: 5),
            InkWell(
                onTap: () => {
                      // _launchUrl(message['photo'].toString()),
                      Get.to(() => WebViewDoc(message['photo'].toString()))
                    },

                // _launchUrl("https://www.clickdimensions.com/links/TestPDFfile.pdf"),
                child: Container(
                    height: 90,
                    width: 150,
                    child: Image.asset(
                      'assets/images/file.png',
                      fit: BoxFit.contain,
                    )))
          ],
        ),
        decoration: BoxDecoration(
          color: isMe ? userColor : oppoColor,
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (Platform.isAndroid) {
      // final Uri _url = Uri.parse(url);
      if (!await launch(url)) {
        throw 'Could not launch $url';
      }
    } else {
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }
  }

  void openCamera(String type) async {
    final imgPicker = ImagePicker();

    final XFile? photo = type == "photo"
        ? await imgPicker.pickImage(
            source: ImageSource.camera, imageQuality: 30)
        : await imgPicker.pickVideo(source: ImageSource.camera);

    if (isBigFile(File(photo!.path))) {
      Util.showErrorToast("big_file_size".tr);
    } else {
      uploadImage(File(photo.path));
    }
  }

  void openGallery(String type) async {
    final imgPicker = ImagePicker();

    final XFile? photo = type == "photo"
        ? await imgPicker.pickImage(
            source: ImageSource.gallery, imageQuality: 30)
        : await imgPicker.pickVideo(source: ImageSource.gallery);

    if (isBigFile(File(photo!.path))) {
      Util.showErrorToast("big_file_size".tr);
    } else {
      uploadImage(File(photo.path));
    }
  }

  bool isBigFile(final File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 10) {
      return true;
    }
    return false;
  }

  uploadImage(File imageFile) async {
    Util.showLoader();

    String type = imageFile.path.split('/').last.toLowerCase();

    String url = await dbHelper.uploadImage1(
      File(imageFile.path),
      userId,
      myId,
    );

    String thumbnailURL = "";
    if (type.contains(".mp4") || type.contains(".mov")) {
      String localPath = await generateThumbnail(imageFile.path);
      thumbnailURL = await dbHelper.uploadImage1(
        File(localPath),
        userId,
        myId,
      );
    } else {
      thumbnailURL = url;
    }

    sentNotification("");
    await dbHelper.sendMessage(userId, myId, false, "", url, thumbnailURL);
    EasyLoading.dismiss();

    // setState(() => uploadBool = true);
  }

  Future<String> generateThumbnail(String videoURL) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoURL,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 100,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 30,
    );
    return fileName!;
  }

  sendImageMsg(File imageFile) async {
    // var imageUrl = await (await _taskUpload).ref.getDownloadURL();
    // url = imageUrl.toString();

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pathReference = storage.ref().child(imageFile.path);
    String path = await pathReference.getDownloadURL();
    sentNotification("");
    await dbHelper.sendMessage(userId, myId, false, "", path, "");
    // Navigator.pop(context);
  }

  Future<String> sendReportDetailsOnServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("userId....s..${prefs.getInt('UserID')}");
    String responseStr = "";

    var params = {
      'user_id': prefs.getInt('UserID').toString(),
      'message': reportMessageController.text,
      'type': selectedReportType
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.REPORT_USER);
    await networkHelper
        .getServerResponseWithHeader(params, Constants.token)
        .then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }

  Future<String> sentNotification(String msg) async {
    String responseStr = "";

    // var header = "Authorization" : "key=\(FIREBASESERVERKEY)"

    var params = {
      "notification": {
        "title": Constants.name + " sent a message",
        "body": msg,
        "sound": "notification.wav",
        "badge": 0,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      },
      "data": {
        "type": "chat",
        "from_user": myId,
        "to_user": userId,
        "message": msg,
        "isText": true,
        "chat_id": chatId
      },
      // "to": "dh2xD6TdT9egL0YUeMxHyM:APA91bFQokrBfbj-P5cKvB5LV6ZhP8_Ulq1RU6L-lDOzuKgjrgve-ArYtcfxrzYWq1-3FrhnDhoB5KB_eaeLueJWFvlMVQfQep0xyoIFPh7CJJHIMRnJ1LG--8YA1mECeC65-0-YdA9G",
      "to": widget.userData['token']
    };

    NetworkHelper networkHelper = NetworkHelper(Constants.FCMURL);

    await networkHelper.sendFCMNotification(params).then((value) {
      responseStr = value;
      print(value);
    });

    return responseStr;
  }
}

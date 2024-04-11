import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sourcecode/firehelper/chatScreen.dart';
import 'package:sourcecode/screens/chatlisting.dart';
import 'package:sourcecode/screens/contactlist.dart';
import 'package:sourcecode/screens/groupchatlisting.dart';
import 'package:sourcecode/screens/settings.dart';

import '../utils/constant.dart';
import '../utils/util.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 0;
  late TabController tabController;

  final searchTC = TextEditingController();

  final chatListingStateKey = new GlobalKey<ChatListingState>();
  final groupChatListingStateKey = new GlobalKey<GroupChatListingState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPermission();

    initLocalNoti();
    setNotificationData();

    tabController = new TabController(vsync: this, length: 2);
    tabController.addListener(() {
      setState(() {
        selectedTabIndex = tabController.index;
      });
    });

    Util.getStringValue("Token").then((value) {
      // setState(() {
      Constants.token = value;
      // });
    });

    Util.getIntValue("UserID").then((value) {
      // setState(() {
      Constants.userID = value.toString();
      // });
    });

    Util.getStringValue("FirebaseUID").then((value) {
      setState(() {
        Constants.FirebaseUID = value;
      });
    });

    Util.getStringValue("Name").then((value) {
      setState(() {
        Constants.name = value;
      });
    });

    /*Util.getStringValue("Email").then((value) {
      setState(() {
        Constants.email = value;
      });
    });

    Util.getStringValue("Token").then((value) {
      setState(() {
        Constants.profileImg = value;
      });
    });*/
  }

  getPermission() async {
    await [
      Permission.mediaLibrary,
      Permission.photos,
      Permission.storage,
      //Permission.manageExternalStorage
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              getHeaderView(),
              getTabBarView(),
              //getSearchBar(),
            ],
          ),
          bottomNavigationBar: menuWidget(),
        ));
  }

  Widget menuWidget() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: false,
        labelColor: Color.fromRGBO(34, 36, 154, 1.0),
        labelPadding: EdgeInsets.zero,
        unselectedLabelColor: Color.fromRGBO(139, 139, 139, 1.0),
        indicatorColor: Colors.white,
        // labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
        tabs: [
          Tab(
            child: selectedTabIndex == 0
                ? getSelectedView('chat_black.png', "chats".tr)
                : getUnSelectedView('chat.png', "chats".tr),
          ),
          Tab(
            child: selectedTabIndex == 1
                ? getSelectedView('group_black.png', "groups".tr)
                : getUnSelectedView('group.png', "groups".tr),
          ),
        ],
      ),
    );

    // return new Scaffold(backgroundColor: Color.fromRGBO(236, 242, 244, 1.0),
    //     body: Container(decoration: BoxDecoration(color: Colors.yellow), child: Column(children:[topView(), topLogo(), getScrollView()])));
  }

  Container getSelectedView(String imageName, String title) {
    return Container(
        height: 50,
        width: 65,
        // decoration: BoxDecoration(
        // color: Constants.primaryThemeColor,
        // borderRadius: BorderRadius.circular(22.5)),
        child: Column(children: [
          Container(
              alignment: Alignment.center,
              height: 25,
              width: 30,
              child: Image.asset(
                'assets/images/' + imageName,
                width: 30,
                height: 25,
                fit: BoxFit.contain,
              )),
          Text(title,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  )
                  .copyWith(color: Colors.black))
        ]));
  }

  Container getUnSelectedView(String imageName, String title) {
    return Container(
        height: 50,
        width: 65,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(22.5)),
        child: Column(children: [
          Container(
              alignment: Alignment.center,
              height: 25,
              width: 30,
              child: Image.asset(
                'assets/images/' + imageName,
                width: 30,
                height: 25,
                fit: BoxFit.contain,
              )),
          Text(title,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  )
                  .copyWith(color: Color.fromRGBO(119, 119, 119, 1.0)))
        ]));
  }

  void updateSearchQuery(String newQuery) {
    if (selectedTabIndex == 0) {
      chatListingStateKey.currentState!.updateSearchQuery(newQuery);
    } else {
      groupChatListingStateKey.currentState!.updateSearchQuery(newQuery);
    }

    setState(() {});
  }

  Widget getSearchBar() {
    return Positioned(
      top: 85,
      left: 0,
      right: 0,
      child: Container(
          // margin: EdgeInsets.only(left: 10, right: 10, top: 5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0.0, 0.75)),
            ],
          ),
          height: 50,
          child: Stack(children: [
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: TextField(
                  controller: searchTC,
                  onChanged: (value) => updateSearchQuery(value),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      // fontFamily: "Nexa",
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    border: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 15, top: 5, right: 15),
                    hintText: 'search'.tr,
                    fillColor: Colors.white,
                    filled: true,
                    // color: Color.fromRGBO(189, 189, 189, 1.0),
                  ),
                )),
            Positioned(
                top: 4,
                bottom: 5,
                right: 5,
                child: Container(
                  // margin: EdgeInsets.only(right: 10),
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Constants.primaryThemeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/images/search.png',
                      fit: BoxFit.contain,
                      height: 20,
                      width: 20,
                    ),
                  ),
                )),
          ])),
    );
  }

  Widget getHeaderView() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Constants.primaryThemeColor,
        height: 80,
        // height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 25, left: 25),
                height: 40,
                width: 40,
                child: IconButton(
                    onPressed: () => {Get.to(() => Settings())},
                    icon: Image.asset(
                      'assets/images/settings.png',
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 25),
                    child: Text("all_chats".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700)))),
            Container(
                margin: EdgeInsets.only(top: 30, right: 25),
                height: 40,
                width: 40,
                child: IconButton(
                    onPressed: () => {
                          Get.to(() => ContactList(
                                isFromCreateGroup:
                                    tabController.index == 0 ? false : true,
                                isReturnUser: false,
                              ))
                        },
                    icon: new Image.asset(
                      'assets/images/contacts.png',
                    ))),
          ],
        ),
      ),
    );
  }

  Widget getTabBarView() {
    return Positioned(
      top: 80,
      // top: 155,
      left: 0,
      right: 0,
      bottom: 0,
      child: DefaultTabController(
        length: 2,
        child: TabBarView(
          controller: tabController,
          children: [
            ChatScreen(), //ChatListing(key: chatListingStateKey),
            GroupChatListing(
                key:
                    groupChatListingStateKey), //Container(child: Icon(Icons.directions_car)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void initLocalNoti() {
    FlutterLocalNotificationsPlugin flutterNotificationPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future notificationDefaultSound(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '100',
      'Writeme',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    FlutterLocalNotificationsPlugin flutterNotificationPlugin =
        FlutterLocalNotificationsPlugin();

    String payload = "";
    bool isOpenedChat = false;
    if (message.data["type"] == null || message.data["type"] != "chat") {
      payload = message.data["quest"].toString();
    } else {
      String msg = message.data["message"];
      payload = "{\"type\" : \"group_chat\", \"message\" : \"$msg\"}";

      if (Constants.openChatId == message.data["chat_id"]) {
        isOpenedChat = true;
      }
    }

    if (!isOpenedChat) {
      flutterNotificationPlugin.show(1, message.notification!.title,
          message.notification!.body, platformChannelSpecifics,
          payload: (payload));
    }
  }

  Future sendChatLocalNoti(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '100',
      'Writeme',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    FlutterLocalNotificationsPlugin flutterNotificationPlugin =
        FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin.show(1, title, body, platformChannelSpecifics,
        payload: null);
  }

  Future onSelectNotification(String? payload) async {
    //{questId: 3, body: Dharm3 assgned quest., type: assign, title: Quest assigned, click_action: FLUTTER_NOTIFICATION_CLICK}

    if (payload != null) {
      checkQuestNotificationData(payload);
    } else {
      moveToChatScreen();
    }
  }

  setNotificationData() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('A new getInitialMessage event was published!');
        // print('msg'+message.data.toString());
        //
        // var jsonValue = json.decode(message.data["notificationkey"]);
        //
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('A new onMessage event was published!');
      if (message != null) {
        print('msg' + message.data.toString());

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          print(message.data);
          notificationDefaultSound(message);
        }

        // if (Platform.isIOS) {
        // updateNotiTab();
        // }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessage event was published!');

      if (message != null) {
        print('msg' + message.data.toString());

        var type = message.data["type"];
        if (type == "chat") {
          moveToChatScreen();
        } else {
          //checkQuestNotificationData(message.data["quest"].toString());
          moveToGroupChatScreen();
        }
      }
    });

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  moveToChatScreen() {
    //tabController.index = 0;
    Get.offAll(() => Dashboard());
  }

  moveToGroupChatScreen() {
    //tabController.index = 1;
    Get.offAll(() => Dashboard());
  }

  checkQuestNotificationData(String message) {
    if (message != null) {
      var data = json.decode(message);

      var type = data["type"];
      if (type == "chat") {
        moveToChatScreen();
      } else {
        moveToGroupChatScreen();

        /*var userId = data["user_id"].toString();
        var questId = data["id"].toString();

        if (Constants.userID == userId) {
          // Observable.instance.notifyObservers([
          //   "MyQuestDetailState",
          // ], notifyName: "getQuestDetail", map: null);
          //
          // Get.to(() => MyQuestDetail(questId))!.whenComplete(() {
          //   getDashboadData();
          //   getBoostUpData();
          // });
        } else {
          Observable.instance.notifyObservers([
            "QuestDetailState",
          ], notifyName: "getQuestDetail", map: null);

          // Get.to(() => QuestDetail(questId))!.whenComplete(() {
          //   getDashboadData();
          //   getBoostUpData();
          // });
        }*/
      }
    }
  }
}

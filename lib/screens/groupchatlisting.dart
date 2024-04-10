import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:get/get.dart';
import 'package:sourcecode/firehelper/Database.dart';
import 'package:sourcecode/firehelper/GroupChatDetailed.dart';
import 'package:sourcecode/firehelper/OfflineStore.dart';
import 'package:sourcecode/screens/creategroup.dart';

import '../firehelper/chatDetailed.dart';
import '../models/settingsm.dart';
import '../utils/constant.dart';

class GroupChatListing extends StatefulWidget {
  GroupChatListing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return GroupChatListingState();
  }
}

class GroupChatListingState extends State<GroupChatListing> with Observer {
  List<SettingsM> items = [];
  List<SettingsM> originalItems = [];

  late DatabaseHelper dbHelper;
  late OfflineStorage offlineStorage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Observable.instance.addObserver(this);

    items.add(SettingsM(title: "School Friends", image: "Kamal shared a image"));
    items.add(SettingsM(title: "Colleage Friends", image: "Hey, Guys"));
    items.add(SettingsM(title: "Colleagues", image: "Hi, How are you?"));

    originalItems = List.from(items);

    dbHelper = new DatabaseHelper();
    offlineStorage = new OfflineStorage();
  }

  @override
  update(Observable observable, String? notifyName, Map? map) {
    if (notifyName == "GroupUpdated") {
        setState(() {

        });
    } else {}
  }

  @override
  void dispose() {
    Observable.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Color.fromRGBO(137, 207, 240, 1.0),
      body: Stack(
        children: [
          getChatList(),
        ],
      ),
    );
  }

  Positioned getChatList() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: FutureBuilder(
        future: offlineStorage.getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot userDataSnapshot) {
          if (userDataSnapshot.hasData) {
            Map<dynamic, dynamic> user = userDataSnapshot.data;
            String myId = user['uid'];
            return StreamBuilder(
              stream: dbHelper.getGroupsList(myId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot qSnap = snapshot.data as QuerySnapshot;

                  // qSnap.docs.asMap().forEach((index, data) {
                  //   var mmsg = data.reference;
                  //   var mmsg1 = data.id;
                  //   var mmsg2 = "";
                  // });

                  List<DocumentSnapshot> docs = qSnap.docs;
                  if (docs.length == 0)
                    return Center(
                      child: Text('no_groups_chat'.tr),
                    );
                  return MediaQuery.removePadding(context: context,
                      removeTop: true,
                      child: ListView.separated(
                        itemCount: docs.length,
                        separatorBuilder: (context, index) =>Divider(height: 10, color: Colors.transparent),
                        itemBuilder: (context, index) {
                          // List<dynamic> members = docs[index].data()['members'];
                          // qSnap
                          var t = docs[index].data() as Map<String, dynamic>;
                          List<dynamic> members = t['members'];
                          String lastMsg = t['lastMessage'] ?? "";
                          String senderId = t['lastSenderId'] ?? "";
                          // String createdAt = t['createdAt'] ?? "";
                          Timestamp time = t['createdAt'] ?? TimeOfDay.now();
                          // DateTime ttime = time.toDate();
                          String userId;
                          userId = members.elementAt(0) == myId
                              ? members.elementAt(1)
                              : members.elementAt(0);
                          return FutureBuilder(
                            future: dbHelper.getUserByUsername(userId),
                            builder: (context, _snapshot) {
                              if (_snapshot.hasData && (_snapshot.data! as DocumentSnapshot).data() != null) {
                                DocumentSnapshot doc = _snapshot.data! as DocumentSnapshot;
                                Map<String, dynamic> _user = doc.data() as Map<String, dynamic>;
                                return TextButton(
                              // splashColor:Colors.transparent,
                              onPressed: (() {
                              String myUid = Constants.FirebaseUID;
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                              GroupChatDetailed(t, myUid,)));
                              }),child: Card(
                                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),

                                    child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      height:60,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            t["groupIcon"].toString().isEmpty ? Container(height: 50, width: 50, child: Image.asset(
                                              'assets/images/group.png',
                                              fit: BoxFit.fill,
                                            )) : CachedNetworkImage(
                                              imageUrl: t['groupIcon'].toString(),
                                              placeholder: (context, url) => CupertinoActivityIndicator(),
                                              imageBuilder: (context, image) => Container(
                                                height: 50, width: 50,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: image,
                                                    fit: BoxFit.cover,),
                                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                                ),

                                              ),
                                              errorWidget: (context, url, error) => CircleAvatar(
                                                  backgroundColor: Colors.grey,
                                                  child: CupertinoActivityIndicator()
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.02,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [SizedBox(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    0.43,
                                                child: Text(
                                                  t['groupName'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                                // SizedBox(
                                                //   width: MediaQuery
                                                //       .of(context)
                                                //       .size
                                                //       .width *
                                                //       0.43,
                                                //   child: new Text(
                                                //     t['recentMessage'].toString(), // "Yoo",
                                                //     maxLines: 1,
                                                //     overflow: TextOverflow.ellipsis,
                                                //     style: TextStyle(
                                                //       fontSize: 10,
                                                //       fontWeight: FontWeight.w600,
                                                //     ),
                                                //   ),
                                                // )
                                              ],),
                                            SizedBox(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.25,
                                              child: Align(
                                                alignment: Alignment
                                                    .centerRight,
                                                // child: _timeDivider(docs[index]
                                                //     .data()['lastActive']),
                                                //   var t = docs[index].data() as Map<String, dynamic>;;
                                                child:
                                                _timeDivider(time),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                  margin: EdgeInsets.all(10.0),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.06,
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
                                ),
                              );
                            },
                          );
                        },
                      ));
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(
                      Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(
                Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
            ),
          );
        },
      ),
    );
  }

  String getLastMsgText(String lastMsg, String senderId){

    if (lastMsg.toLowerCase().contains("sent a")){

      if (senderId == Constants.FirebaseUID){
        return lastMsg;
      }else{
        return lastMsg.replaceAll("Sent a", "Received a");
      }

    }else{
      return lastMsg;
    }

  }



  Widget _timeDivider(Timestamp time) {
    DateTime t = time.toDate();
    String minute =
    t.minute > 9 ? t.minute.toString() : '0' + t.minute.toString();
    String ampm = t.hour >= 12 ? "PM" : "AM";
    int hour = t.hour >= 12 ? t.hour % 12 : t.hour;
    DateTime press = DateTime.now();
    if (press.year == t.year && press.month == t.month && press.day == t.day)
      return Text(hour.toString() + ':' + minute + ' ' + ampm);
    return Text(t.day.toString() +
        '/' +
        (t.month + 1).toString() +
        '/' +
        t.year.toString());
  }


  /*Widget getMenuList() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemBuilder: (context, index) => (GestureDetector(
                  onTap: () => {
                    Get.to(() => CreateGroup())
                  },
                  child: getCellItem(index))),
              itemCount: items.length,
              shrinkWrap: true,
            )));
  }

  Container getCellItem(int idx) {
    SettingsM item = items[idx];

    // String imgName = "globe.png";

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
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.fill,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.title!,
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
                      Text(item.image!,
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
  }*/

  void updateSearchQuery(String newQuery) {
    items.clear();

    if (newQuery.isNotEmpty) {
      originalItems.forEach((element) {
        if (element.title!.toLowerCase().contains(newQuery.toLowerCase())) {
          items.add(element);
        }
      });
    } else {
      items.addAll(originalItems);
    }

    setState(() {});
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';
import 'Database.dart';
import 'OfflineStore.dart';

import 'chatDetailed.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DatabaseHelper dbHelper;
  late OfflineStorage offlineStorage;
  late TextEditingController userController;
  final _scaffKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userController = new TextEditingController();
    // setState(() {
    dbHelper = new DatabaseHelper();
    offlineStorage = new OfflineStorage();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffKey,
        body: Container(
          color: Color.fromRGBO(137, 207, 240, 1.0),
          child: Stack(
            children: [
              getChatList(),
            ],
          ),
        ));
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
              stream: dbHelper.getChats(myId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot qSnap = snapshot.data as QuerySnapshot;
                  List<DocumentSnapshot> docs = qSnap.docs;
                  if (docs.length == 0)
                    return Center(
                      child: Text('no_message_yet'.tr),
                    );
                  return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.separated(
                        itemCount: docs.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 10, color: Colors.transparent),
                        itemBuilder: (context, index) {
                          var t = docs[index].data() as Map<String, dynamic>;
                          List<dynamic> members = t['members'];
                          String lastMsg = t['lastMessage'] ?? "";
                          String id = t['id'] ?? '';
                          String senderId = t['lastSenderId'] ?? "";
                          String userId;
                          userId = members.elementAt(0) == myId
                              ? members.elementAt(1)
                              : members.elementAt(0);
                          return FutureBuilder(
                            future: dbHelper.getUserByUsername(userId),
                            builder: (context, _snapshot) {
                              if (_snapshot.hasData &&
                                  (_snapshot.data! as DocumentSnapshot)
                                          .data() !=
                                      null) {
                                DocumentSnapshot doc =
                                    _snapshot.data! as DocumentSnapshot;
                                Map<String, dynamic> _user =
                                    doc.data() as Map<String, dynamic>;
                                return TextButton(
                                  // splashColor:Colors.transparent,
                                  onPressed: (() {
                                    String myUid = Constants.FirebaseUID;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatDetailed(
                                                  id,
                                                  _user,
                                                  myUid,
                                                )));
                                  }),
                                  child: Card(
                                    margin:
                                        EdgeInsets.only(left: 8.0, right: 8.0),
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      height: 60,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            _user["photo"] == null &&
                                                    _user["photo"]
                                                        .toString()
                                                        .isEmpty
                                                ? Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Image.asset(
                                                      'assets/images/user.png',
                                                      fit: BoxFit.fill,
                                                    ))
                                                : CachedNetworkImage(
                                                    imageUrl: _user['photo']
                                                        .toString(),
                                                    placeholder: (context,
                                                            url) =>
                                                        CupertinoActivityIndicator(),
                                                    imageBuilder:
                                                        (context, image) =>
                                                            Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: image,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25)),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            child:
                                                                CupertinoActivityIndicator()),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.43,
                                                  child: Text(
                                                    _user['name'].toString(),
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.43,
                                                  child: new Text(
                                                    getLastMsgText(lastMsg,
                                                        senderId), // "Yoo",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                // child: _timeDivider(docs[index]
                                                //     .data()['lastActive']),
                                                //   var t = docs[index].data() as Map<String, dynamic>;;
                                                child: _timeDivider(
                                                    t['lastActive']),
                                                // child: Text("3Jan"),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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
                          );
                        },
                      ));
                }
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }

  String getLastMsgText(String lastMsg, String senderId) {
    if (lastMsg.toLowerCase().contains("sent a")) {
      if (senderId == Constants.FirebaseUID) {
        return lastMsg;
      } else {
        return lastMsg.replaceAll("Sent a", "Received a");
      }
    } else {
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

  showSnackPlz(BuildContext context, String username) {
    final SnackBar snackMe = SnackBar(
      content: new RichText(
        text: new TextSpan(
          style: new TextStyle(
            fontSize: 14.0,
          ),
          children: <TextSpan>[
            new TextSpan(
              text: 'User with email ',
            ),
            new TextSpan(
              text: username,
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new TextSpan(
              text: '@gmail.com not in the database!',
            ),
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackMe);
  }

  showSnackPlzWithMessage(BuildContext context, String message) {
    final SnackBar snackMe = SnackBar(
      content: new Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackMe);
  }
}

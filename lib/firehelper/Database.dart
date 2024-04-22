import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sourcecode/utils/constant.dart';

class DatabaseHelper {
  late FirebaseFirestore _db;

  // FirebaseStorage _firebaseStorage =
  //     FirebaseStorage(storageBucket: Constants.firebaseReferenceURI);
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late UploadTask _uploadTask;

  DatabaseHelper() {
    _db = FirebaseFirestore.instance;
  }

  Future<dynamic> getUserByUsername(@required String username) async {
    return await _db.collection('users').doc(username).get();
  }

  Future<String> getUserToken(@required String username) async {
    DocumentSnapshot document =
        await _db.collection('users').doc(username).get();
    String name = document['token'];

    if (name == null) {
      name = "";
    }

    return name;
  }

  getUserByEmail(@required String email) async {
    // return await _db.collection('users').where('email', isEqualTo: email).get();
    return await _db
        .collection('users')
        .where('phoneno', isEqualTo: email)
        .get();
  }

  getGroupDetails(@required String groupId) async {
    // return await _db.collection('users').where('email', isEqualTo: email).get();
    return await _db
        .collection('groups')
        .where('groupId', isEqualTo: groupId)
        .get();
  }

  getChats(@required String userId) {
    return _db
        .collection('chats')
        .where('members', arrayContains: userId)
        .orderBy('lastActive', descending: true)
        .snapshots();
  }

  getGroupsList(@required String userId) {
    return _db
        .collection('groups')
        .where('members', arrayContains: Constants.FirebaseUID)
        .orderBy('lastActive', descending: true)
        // .orderBy('createdAt', descending: true)
        .snapshots();
    // .where('members', arrayContains: userId)
  }

  // String getChatsLastMsg(@required var ref) {
  //   getChatsLastMsgData(ref).then((value) => {
  //     return value
  //   });
  //   return "";
  // }

  Future<String> getChatsLastMsg(@required var ref) async {
    String msg = "";
    // Stream<QuerySnapshot> msgs =
    await ref
        .collection("messages")
        .orderBy('time', descending: true)
        .limit(1)
        .snapshots()
        .forEach((field) {
      msg = field.docs[0]["message"];
      // field.docs.asMap().forEach((index, data) {
      //   msg = data["message"];
      // });
    });
    return msg;
  }

  getChat(
    @required String userId,
    @required String myId,
  ) {
    String chatId = generateChatId(userId, myId);
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  getGroupChat(@required String groupId) {
    return _db
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  generateChatId(@required String username1, @required String username2) {
    return username1.toString().compareTo(username2.toString()) < 0
        ? username1.toString() + '-' + username2.toString()
        : username2.toString() + '-' + username1.toString();
  }

  Future<bool> checkChatExistsOrNot(
      @required String username1, @required String username2) async {
    String chatId = generateChatId(username1, username2);
    DocumentSnapshot doc = await _db.collection('chats').doc(chatId).get();
    return doc.exists;
  }

  sendMessage(
    String id,
    String to,
    String from,
    bool isText,
    String msg,
    String path,
    String videoThumbnail,
  ) async {
    bool existsOrNot = await checkChatExistsOrNot(to, from);
    FirebaseFirestore tempDb = FirebaseFirestore.instance;
    String chatId = generateChatId(from, to);
    Timestamp now = Timestamp.now();

    // Map<String, dynamic> lastMsg = {};
    String lastMsg = "";

    if (!existsOrNot) {
      List<String> members = [to, from];
      if (isText) {
        await tempDb.collection('chats').doc(chatId).collection('messages').add(
          {
            'from': from,
            'to': to,
            'message': msg,
            'time': now,
            'isText': true,
            "type": "text",
            'videoUrl': videoThumbnail
          },
        );
        lastMsg = msg;
      } else {
        String type = path.split('/').last.toLowerCase();

        if (type.contains(".jpg") ||
            type.contains(".jpeg") ||
            type.contains(".png")) {
          type = "image";
          lastMsg = "Sent a image";
        } else if (type.contains(".mp4") || type.contains(".mov")) {
          type = "video";
          lastMsg = "Sent a video";
        } else {
          type = "file";
          lastMsg = "Sent a file";
        }

        await tempDb.collection('chats').doc(chatId).collection('messages').add(
          {
            'from': from,
            'to': to,
            'photo': videoThumbnail,
            'time': now,
            'isText': false,
            "type": type,
            'videoUrl': path
          },
        );
      }
      ;
      await tempDb
          .collection('chats')
          .doc(chatId)
          .set({'lastActive': now, 'members': members, 'id': id});
      tempDb
          .collection('chats')
          .doc(chatId)
          .update({'lastMessage': lastMsg, "lastSenderId": from, 'id': id});
    } else {
      if (isText) {
        await tempDb.collection('chats').doc(chatId).collection('messages').add(
          {
            'from': from,
            'to': to,
            'message': msg,
            'time': now,
            'isText': true,
            "type": "text",
            'videoUrl': videoThumbnail
          },
        );
        lastMsg = msg;
      } else {
        String type = path.split('/').last.toLowerCase();

        if (type.contains(".jpg") ||
            type.contains(".jpeg") ||
            type.contains(".png")) {
          type = "image";
          lastMsg = "Sent a image";
        } else if (type.contains(".mp4") || type.contains(".mov")) {
          type = "video";
          lastMsg = "Sent a video";
        } else {
          type = "file";
          lastMsg = "Sent a file";
        }

        await tempDb.collection('chats').doc(chatId).collection('messages').add(
          {
            'from': from,
            'to': to,
            'photo': videoThumbnail,
            'time': now,
            'isText': false,
            "type": type,
            "type": type,
            'videoUrl': path
          },
        );
        // lastMsg = "Sent a photo";
      }
      await tempDb
          .collection('chats')
          .doc(chatId)
          .update({'lastActive': now, "lastSenderId": from});
      tempDb
          .collection('chats')
          .doc(chatId)
          .update({'lastMessage': lastMsg, 'id': id});
    }
  }

  sendGroupMessage(String to, String senderName, String from, bool isText,
      String msg, String path, String videoThumbnail, String groupId) async {
    FirebaseFirestore tempDb = FirebaseFirestore.instance;
    // String chatId = generateChatId(from, to);
    Timestamp now = Timestamp.now();

    // Map<String, dynamic> lastMsg = {};
    String lastMsg = "";

    List<String> members = [to, from];
    if (isText) {
      await tempDb.collection('groups').doc(groupId).collection('messages').add(
        {
          'from': from,
          'to': to,
          'senderName': senderName,
          'message': msg,
          'time': now,
          'isText': true,
          "type": "text",
          'videoUrl': videoThumbnail
        },
      );
      lastMsg = msg;
    } else {
      String type = path.split('/').last.toLowerCase();

      if (type.contains(".jpg") ||
          type.contains(".jpeg") ||
          type.contains(".png")) {
        type = "image";
        lastMsg = "Sent a image";
      } else if (type.contains(".mp4") || type.contains(".mov")) {
        type = "video";
        lastMsg = "Sent a video";
      } else {
        type = "file";
        lastMsg = "Sent a file";
      }

      await tempDb.collection('groups').doc(groupId).collection('messages').add(
        {
          'from': from,
          'senderName': senderName,
          'to': to,
          'photo': videoThumbnail,
          'time': now,
          'isText': false,
          "type": type,
          'videoUrl': path
        },
      );
    }
    // await tempDb
    //     .collection('groups')
    //     .doc(groupId)
    //     .set({'lastActive': now, 'members': members});
    tempDb.collection('groups').doc(groupId).update(
        {'lastMessage': lastMsg, 'lastActive': now, "lastSenderId": from});
  }

  uploadImage(
    @required File image,
    @required String to,
    @required String from,
  ) {
    String chatId = generateChatId(to, from);
    String filePath = 'chatImages/$chatId/${DateTime.now()}.png';
    _uploadTask = _firebaseStorage.ref().child(filePath).putFile(image);
    return _uploadTask;
  }

  uploadImage1(
    @required File image,
    @required String to,
    @required String from,
  ) async {
    String extension = image.path.split('/').last;

    String chatId = generateChatId(to, from);
    // String filePath = 'chatImages/$chatId/${DateTime.now()}.png';
    String filePath = 'chatImages/$chatId/$extension';
    _uploadTask = _firebaseStorage.ref().child(filePath).putFile(image);

    TaskSnapshot storageSnap = await _uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadGroupIconImage(
    @required File image,
    @required String groupId,
  ) async {
    String extension = image.path.split('/').last;

    String filePath = 'groupImages/$groupId/$extension';
    _uploadTask = _firebaseStorage.ref().child(filePath).putFile(image);

    TaskSnapshot storageSnap = await _uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  getURLforImage(String imagePath) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    // StorageReference sRef =
    //     await storage.getReferenceFromUrl(Constants.firebaseReferenceURI);
    Reference pathReference = storage.ref().child(imagePath);
    return await pathReference.getDownloadURL();
  }
}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/constant.dart';
import '../utils/util.dart';
import 'OfflineStore.dart';
// https://stackoverflow.com/questions/66633990/how-to-use-firebase-phone-authentication-with-flutter
class Auth {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  OfflineStorage offlineStorage = new OfflineStorage();

  late Stream<User> user;
  late Stream<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection('groups');

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result =
    await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  void handleSignInWithPhoneNo(String phoneNo, var userDetails) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        // UserCredential result = await auth.signInWithCredential(credential);
        // saveUserDetails(result.user!, userDetails);
      },
      verificationFailed: (FirebaseAuthException e) {
        var msg = e.message;
        var code = e.code;
        print('Exception -> $msg');
        print('Code -> $code');
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          Util.showErrorToast("invalid_mobile_no".tr);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // String smsCode = '123456';
        Constants.FirebaseVeriID = verificationId;
        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        // UserCredential result = await auth.signInWithCredential(credential);

        // saveUserDetails(result.user!, userDetails);

        Util.showSuccessToast("otp_top_code_sent".tr);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<User?>verifyOTP(String verificationId, String otp)async{

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);

      UserCredential result = await auth.signInWithCredential(credential);

      if (result.user != null){
        Constants.FirebaseUID = result.user!.uid;
        return result.user!;
      };

    } catch (e) {
      print(e);
      // switch (e.) {
      // case "invalid-verification-code":
        Util.showErrorToast("invalid_otp".tr);
      //   break;
      // }

      return null;
    }

  }

  saveUserDetails(User user, var userDetails){

    var authHandler = new Auth();
      if (user != null){
        Constants.FirebaseUID = FirebaseAuth.instance.currentUser!.uid;
        authHandler.updateUserData(
            user, Util.checkNull(userDetails["name"]), Util.checkNull(userDetails["profile_image"]),
            Constants.deviceToken);
        Util.saveStringValue("FirebaseUID", FirebaseAuth.instance.currentUser!.uid);
      }
  }

  void resetOTP(String phoneNo) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {

      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          Util.showErrorToast("invalid_mobile_no".tr);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // String smsCode = '123456';
        Constants.FirebaseVeriID = verificationId;
        Util.showSuccessToast("otp_top_code_sent".tr);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }

  void signOut() => _auth.signOut();

  void updateUserData(User u, String name, String profileImg, String token) async {
    DocumentReference ref = _db.collection('users').doc(u.uid);
    // profile = _auth.authStateChanges().switchMap(
    //       (User u) {
    //     if (u != null)
    //       return _db
    //           .collection('users')
    //           .doc(u.uid)
    //           .snapshots()
    //           .map((snap) => snap.data());
    //     return Stream.empty();
    //   },
    // );
    return ref.set({
      'uid': u.uid,
      "phoneno" : u.phoneNumber, // 'email': u.email,
      'photo': Util.checkNull(profileImg),
      'name': name,
      'token' : token,
    }, SetOptions(merge: true));
  }

  Future<bool> updateGroupImg(String groupIcon, String groupId) async {
    DocumentReference ref = groupCollection.doc(groupId);

    await ref.update({'groupIcon': groupIcon});

    return true;
  }

  Future<bool> getGroupDetail(String groupId) async {
    DocumentReference ref = groupCollection.doc(groupId);



    return true;
  }

  // create group
  Future<DocumentReference> createGroup(String userName, String ownerId, String groupName, var members) async {

    DocumentReference groupDocRef = await groupCollection.add({
      'groupName': groupName,
      'groupIcon': '',
      'admin': userName,
      'adminId' : ownerId,
      // 'owernerId' : Constants.FirebaseUID,
      'members': members,
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
      'createdAt' : Timestamp.now(),
      'lastActive' : Timestamp.now()
    });

    // DocumentSnapshot docSnap = await groupDocRef.get();
    // var doc_id2 = docSnap.reference.id;

    await groupDocRef.update({
      // 'members': FieldValue.arrayUnion([user.uid + '_' + userName]),
      'groupId': groupDocRef.id
    });

    // DocumentReference userDocRef = userCollection.document(uid);
    // return await userDocRef.updateData({
    //   'groups': FieldValue.arrayUnion([groupDocRef.documentID + '_' + groupName])
    // });

    return groupDocRef;
  }
}
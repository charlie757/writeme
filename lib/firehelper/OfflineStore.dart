import 'package:shared_preferences/shared_preferences.dart';

class OfflineStorage {
  late SharedPreferences pref;

  saveUserInfo(String photo, String name, String email, String uid) async {
    pref = await SharedPreferences.getInstance();
    await pref.setString("photo", photo);
    await pref.setString("name", name);
    await pref.setString("email", email);
    await pref.setString("uid", uid);
  }

  Future <dynamic> getUserInfo() async {
    pref = await SharedPreferences.getInstance();
    // String uid = pref.getString("FirebaseUID")!;
    String photo = pref.getString("UserPhoto")!;
    String name = pref.getString("Name")!;
    String email = pref.getString("Email")!;
    String uid = pref.getString("FirebaseUID")!;
    return {'photo': photo, 'name': name, 'email': email, 'uid': uid};
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'constant.dart';
import 'util.dart';

class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {

      await Firebase.initializeApp();

      // 3. On iOS, this helps to take the user permissions
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        // TODO: handle the received notifications
      } else {
        print('User declined or has not accepted permission');
      }

      // For testing purposes print the Firebase Messaging token
      String? token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      Constants.deviceToken = token!;
      Util.saveStringValue("DeviceToken", token);

      _initialized = true;
    }
  }
}
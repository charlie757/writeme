import UIKit
import Flutter
import Firebase
import FirebaseAuth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//      FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    //Auth
   override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
              let firebaseAuth = Auth.auth()
              firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
    }
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
              let firebaseAuth = Auth.auth()
//        firebaseAuth.apnsToken  = deviceToken
//                Messaging.messaging().apnsToken = deviceToken
              if (firebaseAuth.canHandleNotification(userInfo)){
                  print(userInfo)
                  return
              }
   }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
             application.applicationIconBadgeNumber = 0
         }
     
     @available(iOS 10.0, *)
     override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
        {
            completionHandler([.alert, .badge, .sound])
        }
    
}

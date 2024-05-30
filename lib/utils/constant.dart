import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static Color primaryThemeColor = Color.fromRGBO(148, 213, 241, 1.0);
  static Color secondaryThemeColor = Color.fromRGBO(112, 112, 112, 1);
  static Color btnsColor = Colors.black;

  static String FCMURL = "https://fcm.googleapis.com/fcm/send";

  static String kGoogleApiKey = "AIzaSyByqp-lxGbUM9ofo61plPg4EHuotqReYEk";

  static String token = "";
  static String mobileNo = "";
  static String name = "";
  static String deviceToken = "";
  static String userID = "";
  static String openChatId = "";
  static String FirebaseUID = "";
  static String FirebaseVeriID = "";

  // static String FCMSERVERKEY = 'AAAAzSYKYJI:APA91bG3ppJVH9vd9HBG5qxKRfeAAMVWhAqqq7WKpnnhdaG64EkZ1NjNGIXuZZRk4j97-T_J2qRh-3ftIqdSoH367MdO9Vv9dOe_yKsL0NmO_p-606gzZxdZ10wIgqRNglFikMBA3FtE';my account id testing
  static String FCMSERVERKEY =
      'AAAA0UUKApg:APA91bFRMmTat2lDjAeQPwbrdSrTkN545XitAs7HTmG-wE9cTfdHLXJFz3iT910RFA-d8P_3kdEgRipsPcgmIQ3y49ff3n4Ch6WzUjXbsBCg0ERx0l0uax96kmb2f3SrIes6WvmCSYQO';

  static String BASEURL = 'https://api.writemee.com/api/'; //live
  // static String BASEURL =
  //     'https://forthproitsolution.work/writeme/api/'; // local
  static String IMGURL = 'https://api.writemee.com/'; //live
  // static String IMGURL = 'https://forthproitsolution.work/writeme/'; // local

  static final LOGINURL = BASEURL + 'androidlogin';
  static final OTPLOGIN = BASEURL + 'otplogin';
  static final RESENDOTP = BASEURL + 'resendOtp';
  static final UPDATE_PROFILE = BASEURL + 'updateProfile';
  static final GET_PROFILE = BASEURL + 'getProfile/';
  static final GER_USER_LIST = BASEURL + 'getUserList';
  static final CONTACT_US = BASEURL + 'inquiry';
  static final DELETE_ACCOUNT = BASEURL + 'deleteAccount';
  static final REPORT_USER = BASEURL + 'userreport';
  static final BLOCK_USER = BASEURL + 'blockuser';
  static final UNBLOCK_USER = BASEURL + 'unblockuser';
  static final GET_BLOCK_LIST = BASEURL + "getBlockUserList";

  static final ABOUT_US_EN = IMGURL + 'page/about-us/en';
  static final ABOUT_US_DE = IMGURL + 'page/about-us/de';
  static final ABOUT_US_CH = IMGURL + 'page/about-us/ch';
  static final ABOUT_US_SP = IMGURL + 'page/about-us/sp';
  static final ABOUT_US_FR = IMGURL + 'page/about-us/fr';
  static final ABOUT_US_AR = IMGURL + 'page/about-us/ar';
  static final ABOUT_US_RU = IMGURL + 'page/about-us/ru';
  static final ABOUT_US_HI = IMGURL + 'page/about-us/hi';

  static final TERMSCONEN = IMGURL + 'page/terms-conditions/en';
  static final TERMSCONDE = IMGURL + 'page/terms-conditions/de';
  static final TERMSCONCH = IMGURL + 'page/terms-conditions/ch';
  static final TERMSCONSP = IMGURL + 'page/terms-conditions/sp';
  static final TERMSCONFR = IMGURL + 'page/terms-conditions/fr';
  static final TERMSCONAR = IMGURL + 'page/terms-conditions/ar';
  static final TERMSCONRU = IMGURL + 'page/terms-conditions/ru';
  static final TERMSCONHI = IMGURL + 'page/terms-conditions/hi';

  static final PRIVACYPOLICYEN = IMGURL + 'page/privacy-policy/en';
  static final PRIVACYPOLICYDE = IMGURL + 'page/privacy-policy/de';
  static final PRIVACYPOLICYCH = IMGURL + 'page/privacy-policy/ch';
  static final PRIVACYPOLICYSP = IMGURL + 'page/privacy-policy/sp';
  static final PRIVACYPOLICYFR = IMGURL + 'page/privacy-policy/fr';
  static final PRIVACYPOLICYAR = IMGURL + 'page/privacy-policy/ar';
  static final PRIVACYPOLICYRU = IMGURL + 'page/privacy-policy/ru';
  static final PRIVACYPOLICYHI = IMGURL + 'page/privacy-policy/hi';

  static final TERMSCONDITIONEN = IMGURL + 'page/terms-conditions/en';
  static final TERMSCONDITIONDE = IMGURL + 'page/terms-conditions/de';
  static final TERMSCONDITIONCH = IMGURL + 'page/terms-conditions/ch';
  static final TERMSCONDITIONSP = IMGURL + 'page/terms-conditions/sp';
  static final TERMSCONDITIONFR = IMGURL + 'page/terms-conditions/fr';
  static final TERMSCONDITIONAR = IMGURL + 'page/terms-conditions/ar';
  static final TERMSCONDITIONRU = IMGURL + 'page/terms-conditions/ru';
  static final TERMSCONDITIONHI = IMGURL + 'page/terms-conditions/hi';

  static final FAQEN = IMGURL + 'page/faq/en';
  static final FAQDE = IMGURL + 'page/faq/de';
  static final FAQCH = IMGURL + 'page/faq/ch';
  static final FAQSP = IMGURL + 'page/faq/sp';
  static final FAQFR = IMGURL + 'page/faq/fr';
  static final FAQAR = IMGURL + 'page/faq/ar';
  static final FAQRU = IMGURL + 'page/faq/ru';
  static final FAQHI = IMGURL + 'page/faq/hi';

  static final HELPEN = IMGURL + 'page/help/en';
  static final HELPDE = IMGURL + 'page/help/de';
  static final HELPCH = IMGURL + 'page/help/ch';
  static final HELPSP = IMGURL + 'page/help/sp';
  static final HELPFR = IMGURL + 'page/help/fr';
  static final HELPAR = IMGURL + 'page/help/ar';
  static final HELPRU = IMGURL + 'page/help/ru';
  static final HELPHI = IMGURL + 'page/help/hi';

  static List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}

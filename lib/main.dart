import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/splash.dart';
import 'utils/apptranslation.dart';

// https://rrtutors.com/tutorials/Google-Translator-Flutter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String language = "en_US";
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  language = prefs.getString('Language') ?? "en_US";

  Get.updateLocale(Locale(language, language == "en_US" ? "US" : "DE"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    // context.locale = Locale('en', 'US');
    return GetMaterialApp(
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      translations: AppTranslation(),
      locale: Get.locale,
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(148, 213, 241, 1.0), elevation: 0),
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      builder: EasyLoading.init(),
    );
  }
}

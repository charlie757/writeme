import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sourcecode/screens/contactus.dart';
import 'package:sourcecode/screens/langsettings.dart';
import 'package:sourcecode/screens/updateprofile.dart';
import 'package:sourcecode/screens/commonwebview.dart';

import '../models/settingsm.dart';
import '../utils/constant.dart';
import '../utils/util.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  List<SettingsM> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items.add(SettingsM(title: "my_profile", image: "edit_profile.png"));
    items.add(SettingsM(title: "language", image: "language.png"));
    items.add(SettingsM(title: "faqs", image: "faq.png"));
    items.add(SettingsM(title: "help", image: "help.png"));
    items.add(SettingsM(title: "privacy_policy", image: "privacy.png"));
    items.add(SettingsM(title: "termscondition", image: "terms.png"));
    items.add(SettingsM(title: "contact_us", image: "contact_us.png"));
    items.add(SettingsM(title: "about_us", image: "about_us.png"));
    items.add(SettingsM(title: "logout", image: "logout.png"));
    items.add(SettingsM(title: "delete_account", image: "delete.png"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Constants.primaryThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("settings".tr,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                  fontWeight: FontWeight.bold,
                )
                .copyWith(color: Colors.black)),
      ),
      // body: Column(
      //   children: [
      //     SizedBox(height: 20,),
      body: getMenuList(),
      // ],
      // )
    );
  }

  Widget getMenuList() {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemBuilder: (context, index) => (GestureDetector(
              onTap: () {
                if (index == 0) {
                  Get.to(() => UpdateProfile());
                } else if (index == 1) {
                  Get.to(() => LangSettings());
                } else if (index == 2) {
                  getFaqURL();
                } else if (index == 3) {
                  getHelpURL();
                } else if (index == 4) {
                  getPrivacyPolicyURL();
                } else if (index == 5) {
                  // Get.to(() => ContactUs());
                } else if (index == 6) {
                  Get.to(() => ContactUs());
                } else if (index == 7) {
                  getAboutUsURL();
                } else if (index == items.length - 2) {
                  customDialogBox(
                      context: context,
                      title: "logout_message".tr,
                      yesTap: () {
                        Util.logout(context);
                      },
                      noTap: () {
                        Get.back();
                      });
                } else if (index == items.length - 1) {
                  customDialogBox(
                      context: context,
                      title: "delete_account_message".tr,
                      yesTap: () {
                        Util.logout(context);
                      },
                      noTap: () {
                        Get.back();
                      });
                }
              },
              child: getCellItem(index))),
          itemCount: items.length,
          shrinkWrap: true,
        ));
  }

  Container getCellItem(int idx) {
    SettingsM item = items[idx];

    // String imgName = "globe.png";

    return Container(
        margin: EdgeInsets.only(
            top: idx == 0 ? 20 : 0, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          // border: Border.all(color: Color.fromRGBO(200, 200, 200, 1.0)),
          color: Color.fromRGBO(232, 245, 253, 1.0),
        ),
        child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 5, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              // color: Color.fromRGBO(147, 212, 240, 1.0),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Constants.primaryThemeColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        'assets/images/' + item.image!,
                        fit: BoxFit.contain,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  Text(item.title!.tr,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                          )
                          .copyWith(color: Colors.black)),
                ])));
  }

  getHelpURL() async {
    String lang = await Util.getStringValue("SelectedLanguageName");
    String url = "";

    if (lang == "england") {
      url = Constants.HELPEN;
    } else if (lang == "china") {
      url = Constants.HELPCH;
    } else if (lang == "spain") {
      url = Constants.HELPSP;
    } else if (lang == "france") {
      url = Constants.HELPFR;
    } else if (lang == "arabic") {
      url = Constants.HELPAR;
    } else if (lang == "russian") {
      url = Constants.HELPRU;
    } else if (lang == "indian") {
      url = Constants.HELPHI;
    } else if (lang == "german") {
      url = Constants.HELPDE;
    } else {
      url = Constants.HELPEN;
    }

    Get.to(() => CommonWebView(
          url,
          "help".tr,
        ));
  }

  getFaqURL() async {
    String lang = await Util.getStringValue("SelectedLanguageName");
    String url = "";

    if (lang == "england") {
      url = Constants.FAQEN;
    } else if (lang == "china") {
      url = Constants.FAQCH;
    } else if (lang == "spain") {
      url = Constants.FAQSP;
    } else if (lang == "france") {
      url = Constants.FAQFR;
    } else if (lang == "arabic") {
      url = Constants.FAQAR;
    } else if (lang == "russian") {
      url = Constants.FAQRU;
    } else if (lang == "indian") {
      url = Constants.FAQHI;
    } else if (lang == "german") {
      url = Constants.FAQDE;
    } else {
      url = Constants.FAQEN;
    }

    Get.to(() => CommonWebView(
          url,
          "faq".tr,
        ));
  }

  getPrivacyPolicyURL() async {
    String lang = await Util.getStringValue("SelectedLanguageName");
    String url = "";

    if (lang == "england") {
      url = Constants.PRIVACYPOLICYEN;
    } else if (lang == "china") {
      url = Constants.PRIVACYPOLICYCH;
    } else if (lang == "spain") {
      url = Constants.PRIVACYPOLICYSP;
    } else if (lang == "france") {
      url = Constants.PRIVACYPOLICYFR;
    } else if (lang == "arabic") {
      url = Constants.PRIVACYPOLICYAR;
    } else if (lang == "russian") {
      url = Constants.PRIVACYPOLICYRU;
    } else if (lang == "indian") {
      url = Constants.PRIVACYPOLICYHI;
    } else if (lang == "german") {
      url = Constants.PRIVACYPOLICYDE;
    } else {
      url = Constants.PRIVACYPOLICYEN;
    }
    print('url..$url');
    Get.to(() => CommonWebView(
          url,
          "privacy_policy".tr,
        ));
  }

  getAboutUsURL() async {
    String lang = await Util.getStringValue("SelectedLanguageName");
    String url = "";

    if (lang == "england") {
      url = Constants.ABOUT_US_EN;
    } else if (lang == "china") {
      url = Constants.ABOUT_US_CH;
    } else if (lang == "spain") {
      url = Constants.ABOUT_US_SP;
    } else if (lang == "france") {
      url = Constants.ABOUT_US_FR;
    } else if (lang == "arabic") {
      url = Constants.ABOUT_US_AR;
    } else if (lang == "russian") {
      url = Constants.ABOUT_US_RU;
    } else if (lang == "indian") {
      url = Constants.ABOUT_US_HI;
    } else if (lang == "german") {
      url = Constants.ABOUT_US_DE;
    } else {
      url = Constants.ABOUT_US_EN;
    }

    Get.to(() => CommonWebView(
          url,
          "about_us".tr,
        ));
  }

  Future<void> customDialogBox(
      {required BuildContext context,
      required String title,
      required Function() yesTap,
      required Function() noTap}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("yes".tr),
                    onTap: yesTap,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("no".tr),
                    onTap: noTap,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

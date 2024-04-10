import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/settingsm.dart';
import '../utils/constant.dart';
import '../utils/networkhelper.dart';
import '../utils/util.dart';


class LangSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return LangSettingsState();
  }
}

class LangSettingsState extends State<LangSettings> {

  String  selectedLang  = "england";
  List<SettingsM> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


        Util.getStringValue("SelectedLanguageName").then((value) {
          setState(() {
            selectedLang = value;
          });
        });

    items.add(SettingsM(title: "England".tr, image: "england.png"));
    items.add(SettingsM(title: "China".tr, image: "china.png"));
    items.add(SettingsM(title: "Spain".tr, image: "spain.png"));
    items.add(SettingsM(title: "France".tr, image: "france.png"));
    items.add(SettingsM(title: "Arabic".tr, image: "uae.png"));
    items.add(SettingsM(title: "Russian".tr, image: "russia.png"));
    items.add(SettingsM(title: "Indian".tr, image: "india.png"));
    items.add(SettingsM(title: "German".tr, image: "germany.png"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Constants.primaryThemeColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("change_language".tr, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)),
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
    return
      // MediaQuery.removePadding(
      //           context: context,
      //           removeTop: true,
      //           child:
      ListView.builder(
        itemBuilder: (context, index) => (GestureDetector(
            onTap: () => {

              setSelectedLanguage(index)

            },
            child: getCellItem(index))),
        itemCount: items.length,
        shrinkWrap: true,
        // )
      );
  }

  Container getCellItem(int idx) {

    SettingsM item = items[idx];

    bool isSelected = false;

    if (item.title!.toLowerCase() == selectedLang){
      isSelected = true;
    }

    return Container(
        margin: EdgeInsets.only(top: idx == 0  ? 20 : 0, left: 20, right: 20, bottom: 20),
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
                    // margin: EdgeInsets.only(right: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Constants.primaryThemeColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        'assets/images/'+item.image!,
                        fit: BoxFit.contain,
                        height: 50,
                        width: 50,
                      ),),
                  ),
                  Expanded(flex: 1, child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10), child: Text(
                      item.title!,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)
                  ))),
                   Visibility(visible: isSelected, child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        'assets/images/tick.png',
                        fit: BoxFit.contain,
                        height: 20,
                        width: 20,
                      ),)),
                ])));
  }

  setSelectedLanguage(int index){

    switch(index){
      case 0:
        selectedLang = "england";

        Get.updateLocale(Locale('en', 'US'));
        Get.appUpdate();

        Util.saveStringValue("Language", "en_US");

        break;

      case 1:
        selectedLang = "china";

        Get.updateLocale(Locale('zh', 'ZH'));
        Get.appUpdate();

        Util.saveStringValue("Language", "zh_ZH");

        break;

      case 2:
        selectedLang = "spain";

        Get.updateLocale(Locale('sp', 'SP'));
        Get.appUpdate();

        Util.saveStringValue("Language", "sp_SP");

        break;

      case 3:
        selectedLang = "france";

        Get.updateLocale(Locale('fr', 'FR'));
        Get.appUpdate();

        Util.saveStringValue("Language", "fr_FR");

        break;

      case 4:
        selectedLang = "arabic";

        Get.updateLocale(Locale('ar', 'AR'));
        Get.appUpdate();

        Util.saveStringValue("Language", "ar_AR");

        break;

      case 5:
        selectedLang = "russian";

        Get.updateLocale(Locale('ru', 'RU'));
        Get.appUpdate();

        Util.saveStringValue("Language", "ru_RU");

        break;

      case 6:
        selectedLang = "indian";

        Get.updateLocale(Locale('hi', 'HI'));
        Get.appUpdate();

        Util.saveStringValue("Language", "hi_HI");

        break;

      case 7:
        selectedLang = "german";

        Get.updateLocale(Locale('de', 'De'));
        Get.appUpdate();

        Util.saveStringValue("Language", "de_DE");

        break;

      default:
        selectedLang = "england";

        Get.updateLocale(Locale('en', 'US'));
        Get.appUpdate();

        Util.saveStringValue("Language", "en_US");

        break;
    }

    Util.saveStringValue("SelectedLanguageName", selectedLang);
    setState(() {

    });
  }

  Future<void> showLogoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("logout_message".tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("yes".tr),
                    onTap: () {
                      Util.logout(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("no".tr),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/settingsm.dart';

class ChatListing extends StatefulWidget {
  ChatListing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return ChatListingState();
  }
}

class ChatListingState extends State<ChatListing> {
  List<SettingsM> items = [];
  List<SettingsM> originalItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // items.add(SettingsM(title: "Mickey", image: "Shared a image"));
    // items.add(SettingsM(title: "Dharmbir Singh", image: "Hey"));
    // items.add(SettingsM(title: "Kamal Singh", image: "Hi, How are you?"));
    // items.add(SettingsM(title: "Kausal", image: "doing well"));

    originalItems = List.from(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: getMenuList());
  }

  Widget getMenuList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemBuilder: (context, index) => getCellItem(index),
          itemCount: items.length,
          shrinkWrap: true,
        ));
  }

  Container getCellItem(int idx) {
    SettingsM item = items[idx];

    // String imgName = "globe.png";

    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 5, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'assets/images/profile_pic.png',
                      fit: BoxFit.fill,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.title!,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              )
                              .copyWith(color: Colors.black)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(item.image!,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.normal,
                              )
                              .copyWith(color: Colors.grey)),
                    ],
                  )
                ])));
  }

  void updateSearchQuery(String newQuery) {
    items.clear();
    if (newQuery.isNotEmpty) {
      originalItems.forEach((element) {
        if (element.title!.toLowerCase().contains(newQuery.toLowerCase())) {
          items.add(element);
        }
      });
    } else {
      items.addAll(originalItems);
    }

    setState(() {});
  }
}

import 'package:flutter/material.dart';

import 'constant.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Constants.primaryThemeColor;
  final Text? title;
  final AppBar? appBar;
  final List<Widget>? widgets;

  /// you can add more fields that meet your needs

  BaseAppBar({Key? key, this.title, this.appBar, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: IconButton(
        icon: Image.asset(
          'assets/images/back_arrow.png',
          width: 25,
          height: 25,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: backgroundColor,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar!.preferredSize.height);
}

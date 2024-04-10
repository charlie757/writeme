import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

class ImageViewer extends StatefulWidget {
  String filePath;
  ImageViewer(this.filePath);
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: new SafeArea(
            left: false,
            top: false,
            right: false,
            bottom: false,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Util.setInnderHeader("", context),
                  getImageView(),
                ],
              ),
            )));
  }

  /*Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: widget.filePath,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.filePath,
            ),
          ),
        ),
      ),
    );
  }*/

  Positioned getImageView() {
    return Positioned(
        top: 110,
        left: 0,
        right: 0,
        bottom: 110,
        child: Hero(
          tag: widget.filePath,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: widget.filePath, //"https://i.imgur.com/7PqjiH7.jpeg1"
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  // borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
              placeholder: (context, url) => CupertinoActivityIndicator(),
              // errorWidget: (context, url, error) => Image.asset(
              //   'assets/images/placeholder.png',
              //   fit: BoxFit.fill,
              // ),
            )),
          ),
        );
  }

}

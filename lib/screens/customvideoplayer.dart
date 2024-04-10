import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:video_player/video_player.dart';

import '../utils/constant.dart';

class CustomVideoPlayer extends StatefulWidget {

  String url = "";

  CustomVideoPlayer(this.url);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          // videoPlayerController?.play();

          chewieController = ChewieController(
            videoPlayerController: videoPlayerController!,
            autoPlay: true,
            looping: false,
          );

        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.secondaryThemeColor,
          // title: Text("".tr),
          actions: <Widget>[
            TextButton(
              // textColor: Colors.white,
              onPressed: () {
                Get.back();
              },
              child: Text("done".tr, style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
              // shape: CircleBorder(side: BorderSide(color: Colors.white)),
            ),
          ],
        ),
        body:chewieController != null ? Chewie(
          controller: chewieController!,
        ) : Center(child: CircularProgressIndicator())
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

}

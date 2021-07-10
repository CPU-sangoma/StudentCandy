
import 'package:aceitflutter/Screens/Insides/CourseDetail_Screen.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo'});
  static const String routeName = "/cinema";
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
      CourseDetail.introVid);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }
 var appbar = AppBar(
   title: Text("Intro Video",
     style: TextStyle(
       color: Colors.brown[900],
     ),
   ),
   backgroundColor:Colors.yellow[700],
 );

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      home: Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: appbar,
        body: Container(
          height: mq.size.height* 0.4,
          width: mq.size.width * 1,
          child: Chewie(
            controller: _chewieController,
          ),
        )
      ),
    );
  }
}
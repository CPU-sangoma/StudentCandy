import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';


class MyVidPlayer extends StatefulWidget {
 final String vidUrl;
 final bool loop;
 final ChewieController cc;

 MyVidPlayer({
   @required this.vidUrl,
   this.loop,
   this.cc,
   Key key,
}) : super(key:key);
  @override
  _MyVidPlayerState createState() => _MyVidPlayerState();
}
class _MyVidPlayerState extends State<MyVidPlayer> {
  var _videoPlayController;
  Future<void> _future;

  @override
  void initState() {
    super.initState();
    _videoPlayController = VideoPlayerController.network(widget.vidUrl);

    widget.cc.addListener(() {

      if(widget.cc.isFullScreen){
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,

        ]);
      }else{
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: widget.cc,
    );
  }


  @override
  void dispose() {

    _videoPlayController.dispose();
    widget.cc.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

}

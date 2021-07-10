import 'package:aceitflutter/Screens/Insides/Lecture_Screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';



class ChapterWidget extends StatefulWidget {
  List datas;




  ChapterWidget({
    @required this.datas,



});

  @override
  _ChapterWidgetState createState() => _ChapterWidgetState();
}



class _ChapterWidgetState extends State<ChapterWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.datas.length,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            setState(() {
              print("awelee ${LectureHallScreen.Scurrent = index}");
              LectureHallScreen.currentVid = "${widget.datas[LectureHallScreen.Scurrent].content_file}";
              print(LectureHallScreen.currentVid);
              Provider.of<CourseList>(context,listen: false).ChangeVid();
            });
          },
          splashColor: Colors.red,
          child: ListTile(
            leading: Container(child: CircleAvatar(child: LectureHallScreen.Scurrent ==index ? Icon(Icons.play_circle_outline,size: 30.0) : Text("${index+1}"),backgroundColor: Colors.yellow[700],foregroundColor: Colors.white,)),
            title: Text(widget.datas[index].name,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),),
            subtitle: Text(widget.datas[index].content_type,style: TextStyle(
              color: Colors.brown[900],
              fontWeight: FontWeight.bold,
            ),),
            trailing: widget.datas[index].content_type == "mp4" ?  Icon(Icons.videocam,size: 30.0,color: Colors.brown[900],) : Icon(Icons.filter,size: 30.0,color: Colors.brown[900],),
          ),
        );
      },
    );
  }
}

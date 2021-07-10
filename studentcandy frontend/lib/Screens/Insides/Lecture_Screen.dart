import 'package:aceitflutter/Screens/Insides/MyquestionsScreen.dart';
import 'package:aceitflutter/Screens/Insides/QuestionRoom.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:aceitflutter/Widgets/ChapterWidget.dart';
import 'package:aceitflutter/Widgets/VideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import  'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:video_player/video_player.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:async/async.dart';




class LectureHallScreen extends StatefulWidget {
  static const routeName = "/LectureHall";
  static int Scurrent = 0;
  static int chatroom;
  static int chapter;
  static String currentVid = "";



  @override
  _LectureHallScreenState createState() => _LectureHallScreenState();
}

class _LectureHallScreenState extends State<LectureHallScreen> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  bool firstTime = true;

  String viz;

  void _initController(String link) {
    _videoPlayerController1 = VideoPlayerController.network(
      link
    )
      ..initialize().then((_) {

      });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true,
    );
  }


  @override
  void initState() {
    super.initState();



  }

  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();

  }

  Future<void> _onControllerChange(String link) async {
    if (_videoPlayerController1 == null) {
      // If there was no controller, just create a new one
      _initController(link);
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _videoPlayerController1;

      // Registering a callback for the end of next frame
      // to dispose of an old controller
      // (which won't be used anymore after calling setState)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController.dispose();

        // Initing new controller
        _initController(link);
      });

      // Making sure that controller is not used by setting it to null
      setState(() {
        _videoPlayerController1 = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   var mq = MediaQuery.of(context);
   var course = Provider.of<CourseList>(context);
   var courseid = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;


    return Scaffold(
      backgroundColor: Colors.amber[50],
      body:
        FutureBuilder<List>(
            future: course.GetContents(courseid['chapterid']),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }else if(snapshot.connectionState == ConnectionState.done){
                if(firstTime){
                  firstTime = false;
                  _initController(snapshot.data[0].content_file);
                }
                return Column(
                  children: <Widget>[
                    Consumer<CourseList>(
                        builder: (context,co,child){
                          return  Container(
                              margin: EdgeInsets.only(top:mq.padding.top),
                              height: (mq.size.height - mq.padding.top) * 0.3,
                              color: Colors.black,
                              child:  Chewie(
                                controller: _chewieController,
                              ),
                          );
                        }
                    ),
                    Container(
                      height: (mq.size.height - mq.padding.top) * 0.07,
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          RaisedButton.icon(
                            icon: Icon(Icons.chat_bubble,color: Colors.white,),
                            color: Colors.pink,
                            onPressed: (){
                              LectureHallScreen.chatroom = courseid['courseid'];
                              LectureHallScreen.chapter = courseid['chapterid'];
                              Navigator.pushNamed(context, QuestionRoomScreen.routeName,arguments: {'course':courseid['courseid'],'chapter':courseid['chapterid']});
                            },
                            label: Text("Ask Question",style: TextStyle(color: Colors.white),),
                          ),
                          Spacer(
                          ),
                          RaisedButton.icon(
                            icon: Icon(Icons.notifications_active,color: Colors.white,),
                            color: Colors.pink,
                            onPressed: (){
                              Navigator.of(context).pushNamed(MyQuestionRoomScreen.routeName);
                            },
                            label: Text("View My Questions",style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0,right: 7.0,top: 10.0),
                        height: (mq.size.height - mq.padding.top) * 0.59,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return InkWell(
                              onTap: (){
                                  print("awelee ${LectureHallScreen.Scurrent = index}");
                                  LectureHallScreen.currentVid = "${snapshot.data[LectureHallScreen.Scurrent].content_file}";
                                  _onControllerChange(LectureHallScreen.currentVid);
                              },
                              splashColor: Colors.red,
                              child: ListTile(
                                leading: Container(child: CircleAvatar(child: LectureHallScreen.Scurrent ==index ? Icon(Icons.play_circle_outline,size: 30.0) : Text("${index+1}"),backgroundColor: Colors.yellow[700],foregroundColor: Colors.white,)),
                                title: Text(snapshot.data[index].name,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),),
                                subtitle: Text(snapshot.data[index].content_type,style: TextStyle(
                                  color: Colors.brown[900],
                                  fontWeight: FontWeight.bold,
                                ),),
                                trailing:Icon(Icons.videocam,size: 30.0,color: Colors.brown[900]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }else{
                return Center(child:Text("something went wrong"));
              }
            }
      ),
    );
  }
}

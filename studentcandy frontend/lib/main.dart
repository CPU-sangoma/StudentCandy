import 'package:aceitflutter/Screens/Insides/All_courses_screen.dart';
import 'package:aceitflutter/Screens/Insides/BrowseAllCoursesScreen.dart';
import 'package:aceitflutter/Screens/Insides/Chapter_Screen.dart';
import 'package:aceitflutter/Screens/Insides/CourseDetail_Screen.dart';
import 'package:aceitflutter/Screens/Insides/CreateCourse.dart';
import 'package:flutter/services.dart';
import 'package:aceitflutter/Screens/Insides/EditProfile.dart';
import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';
import 'package:aceitflutter/Screens/Insides/Lecture_Screen.dart';
import 'package:aceitflutter/Screens/Insides/MyRepliesRoom.dart';
import 'package:aceitflutter/Screens/Insides/IntroScreen.dart';
import 'package:aceitflutter/Screens/Insides/My_courses_screen.dart';
import 'package:aceitflutter/Screens/Insides/MyquestionsScreen.dart';
import 'package:aceitflutter/Screens/Insides/Payfast.dart';
import 'package:aceitflutter/Screens/Insides/QuestionRoom.dart';
import 'package:aceitflutter/Screens/Insides/ResponseScreen.dart';
import 'package:aceitflutter/Screens/Registration/Login_Screen.dart';
import 'package:aceitflutter/Screens/Registration/Signup_Screen.dart';
import 'package:aceitflutter/Screens/Insides/cinema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';



void main(){

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(AceIt());
}

class AceIt extends StatefulWidget {
  @override
  _AceItState createState() => _AceItState();
}

class _AceItState extends State<AceIt> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CourseList(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red[700],
          buttonColor: Colors.orange[500]
        ),
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
        routes: {
          AllCourses.routeName: (ctx) => AllCourses(),
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          PayfastScreen.routeName:(ctx) => PayfastScreen(),
          HomeScreen.routeName: (ctx)=> HomeScreen(),
          BrowseAllCourses.routeName: (ctx)=>BrowseAllCourses(),
          CourseDetail.routeName: (ctx)=> CourseDetail(),
          MyCourses.routeName: (ctx)=> MyCourses(),
          IntroScreen.routeName: (ctx)=>IntroScreen(),
          EditCourseScreen.routeName:(ctx)=>EditCourseScreen(),
          EditProfileScreen.routeName:(ctx)=>EditProfileScreen(),
          LectureHallScreen.routeName: (ctx)=> LectureHallScreen(),
          SelectChapter.routeName: (ctx) => SelectChapter(),
          ChewieDemo.routeName: (ctx) =>ChewieDemo(),
          QuestionRoomScreen.routeName: (ctx) => QuestionRoomScreen(),
          ReplyScreen.routeName: (ctx)=> ReplyScreen(),
          MyQuestionRoomScreen.routeName: (ctx)=>MyQuestionRoomScreen(),
          MyReplyScreen.routeName: (ctx)=> MyReplyScreen(),
        },
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {



  @override
  void initState(){

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                  Text(
                "Student Candy",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).primaryColor
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CircularProgressIndicator(
            ),

          ],

        ),
      ),

    );
  }
}


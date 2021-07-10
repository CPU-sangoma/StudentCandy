import 'package:aceitflutter/Screens/Insides/CourseDetail_Screen.dart';
import 'package:aceitflutter/Widgets/AllCoursesWidget.dart';
import "package:flutter/material.dart";

class AllCourses extends StatelessWidget {
  static const routeName = "/allcourses";

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar();
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20.0)),
              color: Colors.deepOrange
            ),
            padding: EdgeInsets.all(15.0),
            height:
            (mq.size.height - appbar.preferredSize.height - mq.padding.top) *
                0.2,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: RaisedButton(
                onPressed: (){},
                color: Colors.white,
                child: Text("Computing"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            height:
            (mq.size.height - mq.padding.top - appbar.preferredSize.height + 75.0) *
                1,
            child: AllCoursesWidget(),
          ),
        ],
      ),
    );
  }
}

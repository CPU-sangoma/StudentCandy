import 'package:aceitflutter/Screens/Insides/All_courses_screen.dart';
import 'package:aceitflutter/Screens/Insides/Chapter_Screen.dart';
import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:aceitflutter/Widgets/MyCourseWidget.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:async/async.dart';


class MyCourses extends StatefulWidget {
  static const routeName = "/mycourses";

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  var appbar = AppBar();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var course = Provider.of<CourseList>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.amber[50],
        body:FutureBuilder<List<dynamic>>(
              future: course.myEnrolledCourses(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child:CircularProgressIndicator());
                }else{
                  if(snapshot.data.isEmpty){
                    return Center(child:Text("You have not enrolled for any modules, navigate to the search section to search and enroll for one"));
                  }else
                  if(snapshot.connectionState == ConnectionState.done){
                    return Container(
                      padding: EdgeInsets.all(4.0),
                      height: (mq.size.height - mq.padding.top -
                          appbar.preferredSize.height) * 1,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, indx) {
                          return MyCourseWidget(
                                index: indx,
                                data: snapshot.data,
                              );

                        },
                      ),
                    );
                  }else{
                    return Center(child: Text("something went wrong"));
                  }
                }
              },
            ),
    );
  }
}

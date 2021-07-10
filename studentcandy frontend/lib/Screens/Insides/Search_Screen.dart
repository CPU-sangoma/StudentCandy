import 'package:aceitflutter/Screens/Insides/BrowseAllCoursesScreen.dart';
import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';
import 'package:aceitflutter/Widgets/SearchWidget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';


class SearchScreen extends StatefulWidget {
  static const routeName = "/Search";


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List _newslist = [];
  bool firsttime = true;

  @override
  void initState() {
    super.initState();
  }

  Widget searchstate(CourseList course) {
    if (HomeScreen.searchstate == "start") {
      return Center(child: Text("Use the search bar to search for modules"));
    } else if (HomeScreen.searchstate == "done") {
      return ListView.builder(
        itemCount: course.searchedlist.length > 0
            ? course.searchedlist.length
            : 1,
        itemBuilder: (context, index) {
          print(course.searchedlist.isNotEmpty);
          if (course.searchedlist.isEmpty == true) {
            return Center(
                child: Text("No results found for that module, try again"));
          } else {
            return SearchWidget(index: index, course: course.searchedlist);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var course = Provider.of<CourseList>(context);
    var appbar = AppBar();
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body:
      Container(
        padding: EdgeInsets.all(7.0),
        width: mq.size.width * 1,
        child:
        searchstate(course),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.pink[500],
                  content: Text(
                    "You are about to browse all courses",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton.icon(
                        onPressed:(){
                          Navigator.of(context).pushNamed(BrowseAllCourses.routeName).then((value){
                            Navigator.of(context).pop();
                          });
                        },
                        icon: Icon(Icons.tag_faces,color: Colors.white,),
                        label: Text("ok",style: TextStyle(
                          color: Colors.white,
                        ),)
                    ),
                    FlatButton.icon(
                        onPressed:(){
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.cancel,color: Colors.white,),
                        label: Text("cancel",style: TextStyle(
                          color: Colors.white,
                        ),)
                    ),

                  ],
                );
              }
          );

        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.arrow_upward),
      ),

    );
  }
}

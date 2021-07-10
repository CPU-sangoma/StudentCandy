import 'dart:convert';

import 'package:aceitflutter/Screens/Insides/Lecture_Screen.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:aceitflutter/Widgets/commentChapterScaffold.dart';

class SelectChapter extends StatelessWidget {
  static const routeName = "/selectChapter";
  List colors = [
    Colors.amber[800],
    Colors.pink[800],
    Colors.cyan[800],
    Colors.red[800],
    Colors.purple[800],
    Colors.lightGreen[800],
    Colors.deepOrange[800],
    Colors.lightGreen[800],
    Colors.cyan[800],
  ];
  var appbar = AppBar(
    title: Text("Select Chapter"),
    backgroundColor: Colors.yellow[700],
  );

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var course = Provider.of<CourseList>(context);
    var coursedata =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    int courseid = coursedata['data']['id'];
    print(courseid);
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: appbar,
      body: Container(
            padding: EdgeInsets.all(10.0),
            height: (mq.size.height -
                    mq.padding.top -
                    appbar.preferredSize.height) *
                1,
            child: FutureBuilder<List>(
                future: course.myComEnrolledCourses(courseid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2 / 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            LectureHallScreen.Scurrent =0;
                            Navigator.of(context).pushNamed(
                                LectureHallScreen.routeName,
                                arguments: {
                                  'chapterid': snapshot.data[index].meta2['id'],
                                  'courseid': snapshot.data[index].meta['id'],
                                });
                          },
                          child: GridTile(
                            footer: Container(
                                color: Colors.black.withOpacity(0.7),
                                height: (mq.size.height -
                                        mq.padding.top -
                                        appbar.preferredSize.height) *
                                    0.07,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){

                                          course.LoveChapter(chapterId:snapshot.data[index].meta2['id']).then((response){
                                            if(response.statusCode == 201){
                                              Map body = jsonDecode(response.body);
                                              if(body['operations'] == "successfully liked"){
                                                showDialog(
                                                    context: context,
                                                    builder: (context){
                                                      return AlertDialog(
                                                        title: Text("Done"),
                                                        content: Text("You have successfuly liked this chapter"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text("Ok"),
                                                          )
                                                        ],
                                                      );
                                                    }
                                                );
                                              }else{
                                                showDialog(
                                                    context: context,
                                                    builder: (context){
                                                      return AlertDialog(
                                                        title: Text("Done"),
                                                        content: Text("You have successfuly Unliked this chapter"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text("Ok"),
                                                          )
                                                        ],
                                                      );
                                                    }
                                                );

                                              }


                                            }else{
                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return AlertDialog(
                                                      title: Text("Something went wrong"),
                                                      content: Text("couldn't like/unlike this chapter, check internet connections"),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text("OK"),
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );
                                            }

                                          });

                                          },
                                          icon: Icon(Icons.favorite,size: 30.0,color: Colors.red),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: (){
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context){
                                                return CommentOnChapterText(chapterName: snapshot.data[index].meta2['name'],chapId: snapshot.data[index].meta2['id'],);
                                              }
                                            );



                                          },
                                          icon: Icon(Icons.comment,size: 30.0,color: Colors.white,),
                                        )
                                      ],
                                    ))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: colors[index],
                                child: Center(
                                  child: Text(
                                    snapshot.data[index].meta2['name'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                        shadows: [
                                          Shadow(offset: Offset(1.0, 1.0))
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("something went wrong"));
                  }
                })),
    );
  }
}

import 'package:aceitflutter/Screens/Insides/ChapterPurchase.dart';
import 'package:aceitflutter/Screens/Insides/cinema.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Screens/Insides/My_courses_screen.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Widgets/VideoPlayer.dart';
import 'package:video_player/video_player.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:chewie/chewie.dart';

class CourseDetail extends StatefulWidget {
  static const routeName = "/courseDetail";
  static var introVid = "";
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  var appbar = AppBar(
    iconTheme: IconThemeData(color: Colors.brown[900]),
    elevation: 0,
    backgroundColor: Colors.yellow[700],
    title: Text(
      "",
      style: TextStyle(
        color: Colors.brown[900],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseList>(context, listen: false);
    Map courseid =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    var mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: appbar,
        body: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                width: mq.size.width * 1,
                height: (mq.size.height -
                        mq.padding.top -
                        appbar.preferredSize.height) *
                    0.91,
                child: FutureBuilder<List>(
                  future: course.courseDetail(courseid['id']),
                  builder: (context, snapshot) {
                    if (snapshot.hasError == true) {
                      return Center(
                          child: Text(
                              "something went wrong, check your internet connection"));
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Center(
                            child: Text(
                                "something went wrong, check your internet connection"));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        CourseDetail.introVid = "${snapshot.data[0].introduct_vid}";
                        return ListView(
                          children: <Widget>[
                            Text(
                              "${snapshot.data[0].module_code}",
                              style: TextStyle(
                                color: Colors.brown[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              "${snapshot.data[0].moduleName}",
                              style: TextStyle(
                                color: Colors.brown[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: InkWell(
                                child: Container(
                                  height: 300.0,
                                  width: 300.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${snapshot.data[0].thumbnail}",
                                      ),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop)
                                    ),
                                    color: Colors.black,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[   
                                          Center(
                                              child: IconButton(
                                            icon: Icon(Icons.play_circle_outline,
                                                color: Colors.white, size: 46.0),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  ChewieDemo.routeName,arguments: {'intro_vid':"${snapshot.data[0].introduct_vid}"}
                                              );
                                            },
                                          )),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          Text(
                                            "Preview This Course",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      )
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Navigator.of(context).pushNamed(
                                      ChewieDemo.routeName);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: mq.size.width * 1,
                              color: Colors.yellow[400],
                              child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                          color: Colors.brown[900],
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data[0].description}",
                                        style: TextStyle(
                                          color: Colors.brown[900],
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: mq.size.width * 1,
                              color: Colors.yellow[400],
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "About Tutor",
                                    style: TextStyle(
                                      color: Colors.brown[900],
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data[0].tutor['name']} ${snapshot.data[0].tutor['surname']}",
                                    style: TextStyle(
                                      color: Colors.brown[900],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data[0].tutor['varsity_college']}",
                                    style: TextStyle(
                                      color: Colors.brown[900],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "${snapshot.data[0].tutor['about']}",
                                    style: TextStyle(
                                      color: Colors.brown[900],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: mq.size.width * 1,
                              color: Colors.yellow[400],
                              child: Text(
                                "Chapters Available",
                                style: TextStyle(
                                  color: Colors.brown[900],
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: mq.size.width * 1,
                              height: 250.0,
                              color: Colors.yellow[400],
                              child:
                                  FutureBuilder<List>(
                                    future: course.GetChapters(courseid['id']),
                                    builder: (context,snapshot){
                                      if(snapshot.error == true){
                                        return Center(
                                          child: Text("Something went wrong, check your network connection"),
                                        );
                                      }else{
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }else if(snapshot.connectionState == ConnectionState.done){
                                          if(snapshot.hasData == false){
                                            return Center(
                                              child: Text(
                                                "No Chapters available"
                                              ),
                                            );
                                          }else{
                                            return ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context,index){
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: Colors.pink,
                                                    child: Text("${index+1}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                  ),
                                                  title: Text(
                                                    "${snapshot.data[index].name}",
                                                      style: TextStyle(
                                                        color: Colors.brown[900],
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 19.0,
                                                      ),
                                                  ),
                                                  subtitle: Text(
                                                    "${snapshot.data[index].description}",
                                                    style: TextStyle(
                                                      color: Colors.brown[500],
                                                      fontSize: 15.0,
                                                    ),

                                                  ),
                                                );
                                              }
                                            );
                                          }
                                        }else{
                                          return Center(
                                            child: Text("Something went wrong, check your network connection"),
                                          );
                                        }
                                      }
                                    }
                                  ),
                            ),

                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                                "something went wrong, check your internet connection"));
                      }
                    }
                  },
                ),
              ),
            Spacer(),
            Container(
              width: mq.size.width * 1,
              height: (mq.size.height -
                      mq.padding.top -
                      appbar.preferredSize.height) *
                  0.09,
              child: Container(
                padding: EdgeInsets.all(12.0),
                color: Colors.pink,
                child: Row(
                  children: <Widget>[
                    Text(
                      "Buy Chapters",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    RaisedButton.icon(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ChapterPurchase(courseId: courseid['id']);
                        }));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                      ),
                      label: Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

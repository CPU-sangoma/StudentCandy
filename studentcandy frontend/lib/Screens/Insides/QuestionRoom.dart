import 'package:aceitflutter/Screens/Insides/Lecture_Screen.dart';
import 'package:aceitflutter/Screens/Insides/ResponseScreen.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:aceitflutter/Widgets/QuestionWidget.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';

class QuestionRoomScreen extends StatefulWidget {
  static const routeName = "/questionroom";
  static int quizno;

  @override
  _QuestionRoomScreenState createState() => _QuestionRoomScreenState();
}

class _QuestionRoomScreenState extends State<QuestionRoomScreen> {
  TextEditingController question = TextEditingController();
  bool _loading;

  @override
  void dispose() {
    question.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("my God is awesome");
    print("chat ${LectureHallScreen.chatroom}  chapter${LectureHallScreen.chapter}");
    Provider.of<CourseList>(context, listen: false)
        .GetQuestion(LectureHallScreen.chapter)
        .then((_) {
      setState(() {
        _loading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var course = Provider.of<CourseList>(context);
    var appbar = AppBar(
      title: Text("Questions"),
      backgroundColor: Colors.yellow[700],
    );

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: appbar,
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: (mq.size.height -
                          mq.padding.top -
                          appbar.preferredSize.height) *
                      0.87,
                  child: _loading == false
                      ? ListView.builder(
                          itemCount: course.question.length,
                          itemBuilder: (context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                   QuestionWidget(
                                     dex: index,
                                     datas: course.question,
                                   ),
                                ]
                            );
                          })
                      : Center(child: CircularProgressIndicator())),

              //the bottom part, textbox
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    gradient: LinearGradient(colors: [
                      Colors.pink[600],
                      Colors.pink[600],
                      Colors.pink[600],
                    ])),
                padding: EdgeInsets.all(9.0),
                height: (mq.size.height -
                        mq.padding.top -
                        appbar.preferredSize.height) *
                    0.14,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: question,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.yellow[700],
                              width: 4.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Ask question",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _loading = true;
                        });
                        var course =
                            Provider.of<CourseList>(context, listen: false);
                        course.AskQuestion(
                                LectureHallScreen.chapter,
                                question.text,
                                context)
                            .then((response) {
                          if (response.statusCode == 200) {
                            print("${response.statusCode}");
                            setState(() {
                              _loading = false;
                              question.clear();
                            });
                          } else {
                            print("${response.statusCode}");
                            setState(() {
                              _loading = false;
                            });
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

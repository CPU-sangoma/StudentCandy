import 'package:aceitflutter/Screens/Insides/QuestionRoom.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:aceitflutter/Widgets/QuestionWidget.dart';
import 'package:aceitflutter/Widgets/ReplyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Widgets/ResponseWidget.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Widgets/selectedQuestion.dart';

class ReplyScreen extends StatefulWidget {
  static const String routeName = "/replyScreen";

  @override
  _ReplyScreenState createState() => _ReplyScreenState();
}

class _ReplyScreenState extends State<ReplyScreen> {
  TextEditingController response = TextEditingController();
  bool _loading;


  @override
  void initState() {
    super.initState();
    Provider.of<CourseList>(context, listen: false)
        .GetResponse(QuestionWidget.quizno)
        .then((response){
      setState(() {
        _loading = false;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var idnumber = ModalRoute.of(context).settings.arguments as int;
    var course = Provider.of<CourseList>(context);
    var mq = MediaQuery.of(context);
    var appbar = AppBar(
      title: Text("Replies"),
      elevation: 0.0,
      backgroundColor: Colors.yellow[700],
    );
    return Scaffold(
        appBar: appbar,
        backgroundColor: Colors.amber[50],
        body:  SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: (mq.size.height -
                            mq.padding.top -
                            appbar.preferredSize.height) *
                        0.87,
                    child: _loading == false
                        ? ListView.builder(
                            itemCount: course.replies.length,
                            itemBuilder: (context, index) {
                              return ReplyWidget(
                                dex: index,
                                datas: course.replies,
                              );
                            })
                        : Center(child: CircularProgressIndicator())),


                Container(
                  color: Colors.pink[800],
                  padding: EdgeInsets.all(9.0),
                  height: (mq.size.height -
                          mq.padding.top -
                          appbar.preferredSize.height) *
                      0.13,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: response,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 4.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Ask question",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      )),
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

                          course.Respond(idnumber, response.text).then((res) {
                            if (res.statusCode == 200) {
                              setState(() {
                                _loading = false;
                                response.clear();
                              });
                            } else {
                              setState(() {
                                _loading = false;
                                response.clear();
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

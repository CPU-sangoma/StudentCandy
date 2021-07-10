import 'package:aceitflutter/Screens/Insides/Lecture_Screen.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:aceitflutter/Widgets/QuestionWidget.dart';

class MyQuestionRoomScreen extends StatefulWidget {
  static const routeName = "/myquestions";

  @override
  _MyQuestionRoomScreenState createState() => _MyQuestionRoomScreenState();
}

class _MyQuestionRoomScreenState extends State<MyQuestionRoomScreen> {

  TextEditingController question1 = TextEditingController();
  bool _loading;

  @override
  void dispose() {
    question1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Provider.of<CourseList>(context,listen: false).GetMyQuestions(LectureHallScreen.chapter).then((_){
      setState(() {
        _loading = false;
      });
    });
    print("init()");

  }

  cPrint(List list){
    print(list.length);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
   var course = Provider.of<CourseList>(context);
   cPrint(course.question);
    var appbar = AppBar(
      title: Text(" MyQuestions"),
     backgroundColor: Colors.yellow[700],
    );
    return Scaffold(
        appBar: appbar,
        backgroundColor: Colors.amber[50],
        body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: (mq.size.height -
                    mq.padding.top -
                    appbar.preferredSize.height) *
                    0.87,
                child:
                _loading == false ?
                ListView.builder(
                    itemCount: course.question.length,
                    itemBuilder: (context,index){

                      return QuestionWidget(
                        dex: index,
                        datas: course.questionlist,
                      );
                    }
                ): Center(child: CircularProgressIndicator())


            ),

            //the bottom part, textbox
            Container(
              color: Colors.pink[700],
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
                        controller: question1,
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
                      var course = Provider.of<CourseList>(context,listen: false);
                      course.AskQuestion(LectureHallScreen.chapter, question1.text,context).then((response){
                        if(response.statusCode == 200){
                          _loading = false;
                          question1.clear();
                        }else{
                          _loading = false;
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

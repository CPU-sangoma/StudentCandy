import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:provider/provider.dart';

class CommentOnChapterText extends StatefulWidget {
  final String chapterName;
  final int chapId;

  CommentOnChapterText({
    @required this.chapterName,
    @required this.chapId,
  });

  @override
  _CommentOnChapterTextState createState() => _CommentOnChapterTextState();
}

class _CommentOnChapterTextState extends State<CommentOnChapterText> {
  var appbar = AppBar();
  TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var mq = MediaQuery.of(context);
    var course = Provider.of<CourseList>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(widget.chapterName),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: mq.size.height * 0.5,
            width: mq.size.width * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Text(
                    "Write Comment",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0)),
                        gradient: LinearGradient(colors: [
                          Colors.indigo[600],
                          Colors.indigo[600],
                          Colors.indigo[600],
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
                            controller: comment,
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
                                hintText: "Write Comment",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                             course.CommentOnCourse(body: comment.text,chapterId: widget.chapId).then((response){
                               if(response.statusCode == 201){
                                 showDialog(
                                   context: context,
                                   builder: (context){
                                     return AlertDialog(
                                       title: Text("Commented"),
                                       content: Text("you have successfully commented on this chapter"),
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
                                 comment.clear();
                               }else{
                                 showDialog(
                                     context: context,
                                     builder: (context){
                                       return AlertDialog(
                                         title: Text("Something went wrong"),
                                         content: Text("couldn't comment on this chapter, check internet connections"),
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
                                 comment.clear();
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
        ));
  }
}

import 'dart:convert';

import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ReplyWidget extends StatefulWidget {
  List datas;
  int dex;

  ReplyWidget({
    @required this.dex,
    @required this.datas,
});
  @override
  _ReplyWidgetState createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseList>(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  color: Colors.orange,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.brown[900]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "@${widget.datas[widget.dex].author['username']}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${widget.datas[widget.dex].body}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "15/june/2020",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )

                      ],
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.favorite_border,color: Colors.red),
                label: Text("${widget.datas[widget.dex].votes}",style: TextStyle(color: Colors.red)),
                onPressed: (){
                  course.Vote(widget.datas[widget.dex].id).then((response){
                    Map<String,dynamic> data = jsonDecode(response.body);
                    if(response.statusCode == 201){
                        if(data['operations'] == "successfully liked"){

                            showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text("Like reply"),
                                  content: Text("Successfuly liked this chapter"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"),
                                    ),
                                  ],
                                );
                              }
                            );
                        }else{
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text("Like reply"),
                                  content: Text("Successfuly unliked this chapter"),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"),
                                    ),
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
                              content: Text("Make sure network connection is turned on"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            );
                          }
                      );


                    }

                  });


                },
              ) ,
            ],
          ),
        ],
      ),
    );
  }
}

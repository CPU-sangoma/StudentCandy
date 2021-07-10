
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';


class ResponseWidget extends StatefulWidget {
  List datas;
  int dex;

  ResponseWidget({@required this.datas,@required this.dex});

  @override
  _ResponseWidgetState createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {


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
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "@${widget.datas[widget.dex].author['username']}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${widget.datas[widget.dex].body}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        widget.datas[widget.dex].file != "way" ? SizedBox.shrink():
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 1,
                        ),
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
            Consumer<CourseList>(
              builder: (context,info,child){
                return   RaisedButton.icon(
                  icon: Icon(Icons.grade,color: Colors.amber),
                  onPressed: (){
                   course.Vote(widget.datas[widget.dex].id);
                  },
                  label: Text("votes: ${widget.datas[widget.dex].votes}"),
                );
               }
            )
            ],
          ),
        ],
      ),
    );
  }
}

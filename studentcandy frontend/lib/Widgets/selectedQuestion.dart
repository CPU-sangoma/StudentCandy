import 'package:aceitflutter/Screens/Insides/ResponseScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SelQuestionWidget extends StatelessWidget {
  Questions data;

  SelQuestionWidget({@required this.data});
  @override
  Widget build(BuildContext context) {
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
                          "@${data.author['username']}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${data.body}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        data.file != "oh yes"? SizedBox.shrink():
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Image.network("http://aceitlive.herokuapp.com${data.file}",fit: BoxFit.cover,),
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
                icon: Icon(Icons.reply,color: Colors.purple),
                label: Text("View Replies",style: TextStyle(color: Colors.purple)),
                onPressed: () {
                  Navigator.of(context).pushNamed(ReplyScreen.routeName);
                },
              ) ,
            ],
          ),
        ],
      ),
    );
  }
}

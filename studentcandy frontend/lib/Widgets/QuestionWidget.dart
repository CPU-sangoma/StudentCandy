import 'package:aceitflutter/Screens/Insides/ResponseScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionWidget extends StatelessWidget {
  static int quizno;
  List datas;
  int dex;

  QuestionWidget({@required this.datas,@required this.dex});
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
                      border: Border.all(color: Colors.brown[900]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "@${datas[dex].author['username']}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${datas[dex].body}",
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                       datas[dex].file == null ? SizedBox.shrink():
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Image.network("http://aceitlive.herokuapp.com${datas[dex].file}",fit: BoxFit.cover,),
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
            FlatButton.icon(
                icon: Icon(Icons.reply,color: Colors.indigo),
                label: Text("View Replies",style: TextStyle(color: Colors.indigo)),
                onPressed: (){
                  QuestionWidget.quizno = datas[dex].id;
                  print(QuestionWidget.quizno);
                  Navigator.of(context).pushNamed(ReplyScreen.routeName,arguments: datas[dex].id);

                },
              ) ,
            ],
          ),
        ],
      ),
    );
  }
}

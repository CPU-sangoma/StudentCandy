import 'package:aceitflutter/Widgets/QuestionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReplyScreen extends StatelessWidget {
  static const String routeName = "/MyreplyScreen";

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var appbar = AppBar(
      title: Text("Reply"),
      elevation: 5.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Theme
                    .of(context)
                    .primaryColor, Colors.yellow[700]])),
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: EdgeInsets.only(
            top: (mq.size.height -
                appbar.preferredSize.height -
                mq.padding.top) *
                0.02),
        child:
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: (mq.size.height -
                    appbar.preferredSize.height -
                    mq.padding.top) *
                    0.26,
                child: QuestionWidget(),
              ),
              Container(
                height: (mq.size.height -
                    appbar.preferredSize.height -
                    mq.padding.top) *
                    0.58,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context,no){
                    return QuestionWidget();
                  },
                ) ,
              ),

              Container(
                padding: EdgeInsets.all(10.0),
                height: (mq.size.height -
                    appbar.preferredSize.height -
                    mq.padding.top) *
                    0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              prefixIcon:
                              InkWell(onTap: () {},
                                  child: Icon(Icons.tag_faces)),
                              suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Icon(Icons.attach_file)),
                              labelText: "Answer a question",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ) ,
        ),
      ),
    );
  }
}

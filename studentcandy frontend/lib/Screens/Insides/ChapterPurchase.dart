import 'package:aceitflutter/Screens/Insides/Payfast.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Widgets/chapterScaffold.dart';

class ChapterPurchase extends StatefulWidget {
  int courseId;

  ChapterPurchase({@required this.courseId});

  @override
  _ChapterPurchaseState createState() => _ChapterPurchaseState();
}

class _ChapterPurchaseState extends State<ChapterPurchase> {
  var appbar = AppBar(
    backgroundColor: Colors.yellow[700],
    title: Text(
      "Buy a chapter",
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var course = Provider.of<CourseList>(context);
    return Scaffold(
      appBar: appbar,
      backgroundColor: Colors.amber[50],
      body:SingleChildScrollView(
          child: Container(
              height: (mq.size.height -
                      appbar.preferredSize.height -
                      mq.padding.top) *
                  1,
              child: FutureBuilder<List<Chapter>>(
                  future: course.GetChapters(widget.courseId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData == false) {
                      return Text("donti");
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2,
                              mainAxisSpacing: 7.0,
                              crossAxisSpacing: 7.0,
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GridTile(
                                header: Container(
                                  child:  snapshot.data[index].reviews >0 ?

                                    FlatButton.icon(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context){

                                              return ScaffoldChapterPurch(chapterId: snapshot.data[index].id,);

                                            });

                                      },
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 14,
                                        color: Colors.yellow[700],
                                      ),
                                      label: Text(
                                        "Reviews",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                    ): Text(
                                      "No Reviews yet",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0),
                                    ),


                                ),
                                footer: Container(
                                  color: Colors.black.withOpacity(0.4),
                                  height: (mq.size.height -
                                          mq.padding.top -
                                          appbar.preferredSize.height) *
                                      0.07,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "R${snapshot.data[index].price}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Spacer(),
                                        RaisedButton.icon(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "You are about to purchase this chapter"),
                                                    content: Text(
                                                        "you are about to buy this chapter, make sure its from a trusted tutor by reading reviews or its from a tutor you know and trust"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text("OK"),
                                                        onPressed: () {

                                                         Navigator.of(context).pushNamed(PayfastScreen.routeName,arguments: {'data':snapshot.data[index]}).then((value){
                                                           Navigator.of(context).pop();
                                                         });
                                                        },
                                                      ),
                                                      FlatButton(
                                                          child: Text("cancel"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.add_shopping_cart),
                                          label: Text("Buy"),
                                          color: Colors.yellow[700],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                child: Container(
                                  color: Colors.pink,
                                  child: Center(
                                    child: Text(
                                      "${snapshot.data[index].name}",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(child: Text("something went wrong"));
                    }
                  })),
        ),
    );
  }
}

/*

ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, index) {
                        return Text("awelele");
                      },
                    );


Card(
                          child: ListTile(
                            leading: Container(
                              height: 30.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.blue[900],
                              ),
                              child: Card(
                                elevation: 20.0,
                                color: Colors.blue[900],
                                shadowColor: Colors.pink,
                                child: Text(
                                  "R100.00",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            title: Text(
                              snapshot.data[index].description,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: RaisedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            "You are about to purchase this chapter"),
                                        content: Text(
                                            "you are about to buy this chapter, make sure its from a trusted tutor by reading reviews or its from a tutor you know and trust"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              course
                                                  .takeCourse(widget.courseId,
                                                  snapshot.data[index].id)
                                                  .then((value) {
                                                if (value.statusCode == 201) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Purchased complete"),
                                                          content: Text(
                                                              "Congrats, you bought this chapter, go to your purchased chapters to see it"),
                                                        );
                                                      });
                                                } else if (value.statusCode ==
                                                    200) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Bought chapter"),
                                                          content: Text(
                                                              "Looks like you already bought this chapter, go to your bought chapters"),
                                                        );
                                                      });
                                                }
                                              });
                                            },
                                          ),
                                          FlatButton(
                                              child: Text("cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "Buy chapter",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
*/

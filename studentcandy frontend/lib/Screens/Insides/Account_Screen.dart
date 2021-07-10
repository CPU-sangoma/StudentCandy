import 'package:aceitflutter/Screens/Insides/CreateCourse.dart';
import 'package:aceitflutter/Screens/Insides/EditProfile.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatelessWidget {
  static const routeName = "/account";
  var appbar = AppBar();
  String type;
  String mytoken;

  Future<List> gettype() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    type = token.getString('Type');
    mytoken = token.getString('Token');
    List values = [type, mytoken];

    return values;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all((mq.size.height -
                    appbar.preferredSize.height -
                    mq.padding.top) *
                0.02),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: (mq.size.height -
                          appbar.preferredSize.height -
                          mq.padding.top) *
                      0.02,
                ),
                SizedBox(
                  height: (mq.size.height -
                          appbar.preferredSize.height -
                          mq.padding.top) *
                      0.02,
                ),
              ],
            ),
          ),
          FutureBuilder<List>(
              future: gettype(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data[0] == "Tutor") {
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                EditCourseScreen.routeName,
                                arguments: {'token': snapshot.data});
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.school,
                              size: 30.0,
                              color: Colors.brown[900],
                            ),
                            title: Text(
                              "Add/Edit Course",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 30.0,
                              color: Colors.brown[900],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                EditProfileScreen.routeName,
                                arguments: {'token': snapshot.data});
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.person,
                              size: 30.0,
                              color: Colors.brown[900],
                            ),
                            title: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 30.0,
                              color: Colors.brown[900],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox.shrink(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                EditProfileScreen.routeName,
                                arguments: {'token': snapshot.data});
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.person,
                              size: 30.0,
                              color: Colors.brown[900],
                            ),
                            title: Text(
                              "Edit Profile",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 30.0,
                              color: Colors.brown[900],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:aceitflutter/Screens/Insides/Account_Screen.dart';
import 'package:aceitflutter/Screens/Insides/All_courses_screen.dart';
import 'package:aceitflutter/Screens/Insides/My_courses_screen.dart';
import 'package:aceitflutter/Screens/Insides/Search_Screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homePage";
  static String searchresult;
  static String searchstate = "start";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();
  var clist = CourseList();
  Map<int, String> headers = {
    0: "Search Module",
    1: "My modules",
    2: "My account",
  };

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    SearchScreen(),
    MyCourses(),
    Account(),
  ];

  int _selectdpage = 1;

  String barsearchstate = "ok";

  void _navigate(int index) {
    setState(() {
      _selectdpage = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  var appbar = AppBar();

  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseList>(context, listen: false);
    var mq = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: headers[_selectdpage] == "Search Module"
              ? TextField(
                  controller: search,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: "search module e.g infs 122",
                      filled: true,
                      suffixIcon:
                      HomeScreen.searchstate == "start" || HomeScreen.searchstate == "done"?
                      IconButton(
                        icon:Icon(Icons.search,
                            size: 30.0, color: Colors.pink[500]),
                        onPressed: () {
                          setState(() {
                            HomeScreen.searchstate = "loading";
                          });
                          course.SearchByCode(search.text).then((value) {
                            if (value.statusCode == 200) {
                              setState(() {
                                HomeScreen.searchresult = "valid";
                                HomeScreen.searchstate = "done";
                              });
                            } else {
                              setState(() {
                                HomeScreen.searchresult =
                                    "something went wrong";
                                HomeScreen.searchstate = "done";
                              });
                            }
                          });
                        },
                      ):CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink[500]),
                      )),
                )
              : Text(
                  "${headers[_selectdpage]}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          backgroundColor: Colors.yellow[700],
        ),
        body: _pages[_selectdpage],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.amber[50],
            currentIndex: _selectdpage,
            backgroundColor: Colors.indigo,
            onTap: _navigate,
            type: BottomNavigationBarType.shifting,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.pink[500],
                icon: Icon(Icons.search, size: 30.0),
                title: Text("Search Module"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.pink[500],
                icon: Icon(Icons.school, size: 30.0),
                title: Text("My Modules"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.pink[500],
                icon: Icon(Icons.person, size: 30.0),
                title: Text("My Account"),
              ),
            ],
          ),
        );

  }
}

/*
BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.orange,
            currentIndex: _selectdpage,
            backgroundColor: Colors.indigo,
            onTap: _navigate,
            type: BottomNavigationBarType.shifting,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(Icons.search, size: 20.0),
                title: Text("Search Module"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(Icons.school, size: 20.0),
                title: Text("My Modules"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(Icons.person, size: 20.0),
                 title: Text("My Account"),
              ),
            ],
          ),
*/

/*
 bottomNavigationBar: SizedBox(
          height: (mq.size.height - mq.padding.top - appbar.preferredSize.height) * 0.02,
          child: CurvedNavigationBar(
            color: Colors.pink[500],
            backgroundColor: Colors.amber[50],
            height:(mq.size.height - mq.padding.top - appbar.preferredSize.height) * 0.1,
            index: _selectdpage,
            buttonBackgroundColor: Colors.pink[500],
            onTap: _navigate,
            items: <Widget>[
              Icon(Icons.shopping_cart, size: 35.0,color:Colors.amber[50]),
              Icon(Icons.school, size: 35.0,color:Colors.amber[50]),
              Icon(Icons.person, size: 35.0,color:Colors.amber[50]),
            ],
          )


 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aceitflutter/Screens/Insides/CourseDetail_Screen.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:async/async.dart';

class AllCoursesWidget extends StatefulWidget {
  @override
  _AllCoursesWidgetState createState() => _AllCoursesWidgetState();
}

class _AllCoursesWidgetState extends State<AllCoursesWidget> {
  AsyncMemoizer<List<dynamic>> memoizer = AsyncMemoizer<List<dynamic>>();
  Future<List<dynamic>> _fuu;


  @override
  Widget build(BuildContext context) {


  var course = Provider.of<CourseList>(context);
    return FutureBuilder<List>(
        future: course.FillCourses(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }else if(snap.error != null){
            return Text("${snap.error.toString()}");
          }
          else {
            return  Consumer<CourseList>(
              builder: (context,courses,child) {
                return  ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context,index){
                    return  InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(CourseDetail.routeName,arguments: {"id": snap.data[index].id});
                      },
                      child: Container(
                        child: Card(
                            elevation: 5.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(4.0),
                                  child: Image.network("http://10.0.2.2:8000${snap.data[index].thumbnail}"),
                                  width: 100.0,
                                  height: 100.0,
                                ),
                                Container(
                                  height: 170.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("module: ${snap.data[index].moduleName}"),
                                      Text("tutor: ${snap.data[index].tutor['name']}"),
                                      Text("school: ${snap.data[index].university}"),
                                      Text("Enrolled: 1000"),
                                      Text("Price: R75.00"),
                                      RaisedButton.icon(onPressed: (){
                                        Navigator.of(context).pushNamed(CourseDetail.routeName,arguments: {"id": snap.data[index].id});
                                      },icon: Icon(Icons.arrow_forward), label: Text("more"))
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    );
                  },
                );
              }
            );
          }
        });
  }
  Future<List<dynamic>> _cachedata(){
    return memoizer.runOnce(()async{
      return Provider.of<CourseList>(context).FillCourses();
    });
  }
}

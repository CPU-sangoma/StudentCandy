import 'package:flutter/material.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:provider/provider.dart';


class ScaffoldChapterPurch extends StatelessWidget {
  final int chapterId;

  ScaffoldChapterPurch({
    @required this.chapterId
});
  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseList>(context);

    return Scaffold(
      appBar:
      AppBar(
        title: FutureBuilder<List<ChapterComment>>(
          future: course.GetChapterComments(chapterId),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }else{
              return Text("${snapshot.data[0].chapter['name']}");
            }
          }
        ),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FutureBuilder<List<ChapterComment>>(
              future: course.GetChapterComments(chapterId),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else{
                   return  FlatButton.icon(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,size: 30,), label: Text("${snapshot.data[0].chapter['likes']}",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                     ),

                   )) ;
                }
              }
          ),
        ],
      ),
      body: FutureBuilder<List<ChapterComment>>(
          future: course.GetChapterComments(chapterId),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }else{
              return  ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person,size: 30.0,),
                        backgroundColor: Colors.indigo,
                      ),
                      title: Text(
                        "${snapshot.data[index].commenter['username']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: 20.0,
                        ),
                      ),
                      subtitle: Text(
                        "${snapshot.data[index].body}",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
              ) ;
            }
          }
      ),
    );
  }
}

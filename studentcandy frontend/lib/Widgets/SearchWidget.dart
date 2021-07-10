import 'package:aceitflutter/Screens/Insides/CourseDetail_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';

class SearchWidget extends StatelessWidget {
  List<Course> course;
  int index;

  SearchWidget({
    @required this.course,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Container(
      width: mq.size.width *1,
      height: mq.size.height * 0.35,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: mq.size.width *1,
                height: mq.size.height * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(20.0),topLeft: Radius.circular(20.0) ),
                    child: Image.network("${course[index].thumbnail}",fit: BoxFit.cover,)),
              ),
             CircleAvatar(
               radius: 40,
                 backgroundImage: NetworkImage("${course[index].tutor['profilepicture']}"),
                )

            ],
          ),
          Container(

            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Container(
                 color: Colors.white,
                 width: mq.size.width * 0.5,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: <Widget>[
                     Text(
                       "${course[index].module_code}",
                       style: TextStyle(
                         color: Colors.brown[900],
                         fontSize: 19.0,
                         fontWeight: FontWeight.bold,
                         fontStyle: FontStyle.italic,
                       ),
                       overflow: TextOverflow.ellipsis,
                       maxLines: 1,
                       softWrap: false,
                     ),
                     Text(
                       "${course[index].university}",
                       style: TextStyle(
                         color: Colors.brown[900],
                         fontSize: 19.0,
                         fontWeight: FontWeight.bold,
                         fontStyle: FontStyle.italic,
                       ),
                       overflow: TextOverflow.ellipsis,
                       maxLines: 1,
                       softWrap: false,
                     ),
                     Text(
                       "${course[index].tutor['name']} ${course[index].tutor['surname']}",
                       style: TextStyle(
                         color: Colors.brown[900],
                         fontSize: 19.0,
                         fontWeight: FontWeight.bold,
                         fontStyle: FontStyle.italic,
                       ),
                       overflow: TextOverflow.ellipsis,
                       maxLines: 1,
                       softWrap: false,
                     ),
                   ],
                 ),
               ),
               Spacer(),
               RaisedButton.icon(
                 color: Colors.pink,
                 onPressed: (){
                    Navigator.of(context).pushNamed(CourseDetail.routeName,arguments: {"id":course[index].id});
                 },
                   icon: Icon(Icons.arrow_forward,color: Colors.white,),
                   label: Text("Visit",style: TextStyle(color: Colors.white),),

               ),
             ],
            ),
          ),
        ],
      )
    );

  }
}












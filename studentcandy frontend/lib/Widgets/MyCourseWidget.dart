import 'package:aceitflutter/Screens/Insides/Chapter_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aceitflutter/Providers/courseProviders/Courses.dart';



class MyCourseWidget extends StatelessWidget {

 final List<dynamic> data;
 final int index;
 MyCourseWidget({
   @required this.data,
   @required this.index,
});

  @override
  Widget build(BuildContext context) {
    var course = Provider.of<CourseList>(context);
    var mq = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        gradient: LinearGradient(
          colors: [
            Colors.pink[800],
            Colors.pink[300],
          ]
        )
      ),
      padding: EdgeInsets.all(8.0),
      height: mq.size.height * 0.12,
      width: mq.size.width * 0.1,
      child: LayoutBuilder(
        builder: (context,constraint){
          return ListTile(
            onTap: (){
              Navigator.of(context).pushNamed(SelectChapter.routeName,arguments: {'data':data[index].meta});
            },
            title: Text(
              "${data[index].meta['module_name']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              "${data[index].meta['module_code']}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                gradient: LinearGradient(
                  colors: [

                    Colors.pink[300],
                    Colors.pink[800],
                  ]
                )
              ),
              child: Center(child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30.0,
              )),
              height: constraint.maxHeight * 1,
              width: constraint.maxWidth * 0.2,
            ),
          );
        }
      )
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseList with ChangeNotifier {
  List<Course> clist = [];
  List<Course> dclist = [];
  List<Course> enrolledcourses = [];
  List<Chapter> chapterlist = [];
  List<Content> contentlist = [];
  List<Questions> questionlist = [];
  List<Questions> myquestionlist = [];
  List<Replies> replieslist = [];
  List<Course> searchedlist = [];
  List<ChapterComment> chaptercommentlist= [];

  List get courses {
    return [...clist];
  }

  List get question {
    return [...questionlist];
  }

  List get myquestions{
    return [...myquestionlist];
  }

  List get searched {
    return [...searchedlist];
  }

  List get replies{
    return [...replieslist];
  }

  List get dcourses {
    return [...dclist];
  }

  Future<List> FillCourses() async {
    const String url = "https://api.studentcandy.com/popsyman/course/getallcourses";

    var result = await http.get(url);

    List data = jsonDecode(result.body);
    List<Course> newdata = [];

    data.forEach((c) {
      newdata.add(Course(
          certified: c['certified'],
          enrolled: c['enrolled_students_number'],
          faculty: c['faculty'],
          id: c['id'],
          level: c['Level'],
          moduleName: c['module_name'],
          paid: c['paid'],
          thumbnail: c['thumbnail'],
          tutor: c['tutor'],
          university: c['university']));
    });

    clist = newdata;

    return [...clist];
  }

  Future<List> courseDetail(int id) async {
    String url = "https://api.studentcandy.com/popsyman/course/coursedetail/$id";

    var result = await http.get(url);

    Map<String, dynamic> data = jsonDecode(result.body);
    List<Course> newdata = [];

    newdata.add(Course(
        id: data['id'],
        certified: data['certified'],
        description: data['description'],
        moduleName: data['module_name'],
        module_code: data['module_code'],
        enrolled: data['enrolled_students_number'],
        faculty: data['faculty'],
        level: data['Level'],
        paid: data['paid'],
        introduct_vid: data['introduction_vid'],
        thumbnail: data['thumbnail'],
        university: data['university'],
        tutor: data['tutor']));

    dclist = [];
    dclist = newdata;
    return [...dclist];
  }

  Future<http.Response> takeCourse(int course, int chapter) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    var tokkens = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/Takecourse/$course/$chapter";

    return http.post(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $tokkens'
    });


  }

  Future<List<ChapterComment>> GetChapterComments(int chapterid)async{
    SharedPreferences token = await SharedPreferences.getInstance();
    var tokkens = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/getchaptercomments/$chapterid";

    var result = await http.get(url);

    List data = json.decode(result.body);
    List<ChapterComment> newData = [];


    data.forEach((datas) {
      newData.add(
        ChapterComment(id: datas['id'], commenter: datas['commenter'], chapter: datas['chapter'], body: datas['body'])
      );
    });

    chaptercommentlist = [];
    chaptercommentlist = newData;
    return chaptercommentlist;


  }

  Future<List<dynamic>> myEnrolledCourses() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    var tokkens = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/myencourses/";

    var result = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $tokkens'
    });

    List data = jsonDecode(result.body);
    List<Course> newdata = [];

    data.forEach((c) {
      newdata.add(Course(
          certified: c['certified'],
          enrolled: c['enrolled_students_number'],
          faculty: c['faculty'],
          meta: c['course'],
          meta2: c['chapter'],
          id: c['id'],
          level: c['Level'],
          introduct_vid: c['introduction_vid'],
          moduleName: c['module_name'],
          paid: c['paid'],
          thumbnail: c['thumbnail'],
          tutor: c['tutor'],
          university: c['university']));
    });


    enrolledcourses = newdata;

    return [...enrolledcourses];
  }

  Future<List<dynamic>> myComEnrolledCourses(int slug) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    var tokkens = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/myencoursescom/$slug";

    var result = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $tokkens'
    });

    List data = jsonDecode(result.body);
    List<Course> newdata = [];

    data.forEach((c) {
      newdata.add(Course(
          certified: c['certified'],
          enrolled: c['enrolled_students_number'],
          faculty: c['faculty'],
          meta: c['course'],
          meta2: c['chapter'],
          id: c['id'],
          level: c['Level'],
          introduct_vid: c['introduction_vid'],
          moduleName: c['module_name'],
          paid: c['paid'],
          thumbnail: c['thumbnail'],
          tutor: c['tutor'],
          university: c['university']));
    });

    enrolledcourses = newdata;

    print(enrolledcourses[0].meta2);

    return [...enrolledcourses];
  }

  Future<http.Response> CommentOnCourse({String body,int chapterId}) async {

    SharedPreferences token = await SharedPreferences.getInstance();
    var toks = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/chaptercomment/$chapterId";

    Map comment = {
     "body": body,
    };

    return http.post(url,body: json.encode(comment),headers: {
      'Authorization': "Token $toks",
      'Content-type': 'application/json',
    });

  }

  Future<http.Response> LoveChapter({int chapterId})async{

    SharedPreferences token = await SharedPreferences.getInstance();
    var toks = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/lovechapter/$chapterId";
    
    return http.post(url,headers: {
      'Authorization': "Token $toks",
      'Content-type': 'application/json',
    });

  }

  Future<List<Chapter>> GetChapters(int id) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    var toks = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/getchapters/$id";

    var result = await http.get(url, headers: {
      'Content-type': 'application/json',
    });

    List data = jsonDecode(result.body);
    List<Chapter> newdata = [];

    data.forEach((datas) {
      newdata.add(Chapter(
          name: datas['name'],
          likes: datas['likes'],
          reviews: datas['reviews'],
          course: datas['course'],
          tutor: datas['tutor'],
          description: datas['description'],
          length: datas['length'],
          price: double.parse(datas['price']),
          id: datas['id']));
    });

    chapterlist = [];
    chapterlist = newdata;
    return [...chapterlist];
  }

  Future<List> GetQuestion(int chapter) async {
    SharedPreferences token = await SharedPreferences.getInstance();

    String toks = token.getString("Token");
    String url =
        "https://api.studentcandy.com/popsyman/course/getQuestions/$chapter";

    var result = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $toks'
    });

    List data = jsonDecode(result.body);
    List<Questions> newdata = [];

    data.forEach((datas) {
      newdata.add(Questions(
          id: datas['id'],
          body: datas['body'],
          author: datas['author'],
          chatroom: datas['chatroom'],
          file: datas['file']));
    });

    questionlist = [];
    questionlist = newdata;

    print(questionlist);

    return questionlist;
  }



  Future<http.Response> AskQuestion(

      int chapter, String message, BuildContext con) async {
    SharedPreferences token = await SharedPreferences.getInstance();

    Map<String, dynamic> body = {"body": message};
    String toks = token.getString("Token");

    final String url =
        "https://api.studentcandy.com/popsyman/course/askquestion/$chapter";

    return http.post(url, body: jsonEncode(body), headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $toks'
    }).then((response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await jsonDecode(response.body);
        questionlist.add(Questions(
          id: data['id'],
          body: data['body'],
          file: data['file'],
          author: data['author'],
          chatroom: data['chatroom'],
        ));


        notifyListeners();

        return response;
      } else {
        return response;
      }
    });
  }

  Questions SelectedQuestion(int selId) {
    var qus = questionlist.firstWhere((question) {
      return question.id == selId;
    });

    return qus;
  }

  Future<List> GetContents(int id) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    String tokks = token.getString('Token');
    final String url = "https://api.studentcandy.com/popsyman/course/getcontent/$id";

    var result = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $tokks'
    });

    List<Content> newdata = [];
    List data = jsonDecode(result.body);

    data.forEach((datas) {
      newdata.add(Content(
          name: datas['name'],
          chapter: datas['chapter'],
          content_file: datas['content_file'],
          content_type: datas['content_type']));
    });

    contentlist = [];
    contentlist = newdata;
    return [...contentlist];
  }

  void ChangeVid() {
    notifyListeners();
  }

  Future<http.Response>Respond(int question, String message) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    String toks = token.getString("Token");

    String url = "https://api.studentcandy.com/popsyman/course/reply/$question";

    return http.post(
      url,
      body: {'body': message},
      headers: {'Authorization': "Token $toks"},
    ).then((response)async{
      if(response.statusCode == 200){
        Map<String, dynamic> data = await jsonDecode(response.body);
        replieslist.add(Replies(
          id: data['id'],
          body: data['body'],
          file: data['file'],
          author: data['author'],
          question: data['question'],
          votes: data['votes'],
        ));

         print(replieslist.length);
         print(response.statusCode);
        notifyListeners();

        return response;

      }else{
        return response;
      }
    });
  }

  Future<http.Response> SearchByCode(String code) async {
    String url = "https://api.studentcandy.com/popsyman/course/bycode/$code";

    return http.get(url).then((response) {

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<Course> newdata = [];

        data.forEach((element) {
          newdata.add(Course(
            certified: element['certified'],
            enrolled: element['enrolled'],
            faculty: element['faculty'],
            id: element['id'],
            module_code: element['module_code'],
            introduct_vid: element['introduction_vid'],
            level: element['level'],
            moduleName: element['module_name'],
            paid: element['paid'],
            thumbnail: element['thumbnail'],
            tutor: element['tutor'],
            university: element['university'],
          ));
        });

        searchedlist = [];
        searchedlist = newdata;
        notifyListeners();

        return response;
      } else {
        notifyListeners();
        print("error occured");
        return response;
      }
    });
  }

  Future<List> GetMyQuestions(int chapter) async {
    SharedPreferences token = await SharedPreferences.getInstance();

    String toks = token.getString("Token");
    String url = "https://api.studentcandy.com/popsyman/course/myQuestions/$chapter";

    var result = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $toks'
    });


    List data = jsonDecode(result.body);
    List<Questions> newdata = [];

    data.forEach((datas) {
      newdata.add(Questions(
          id: datas['id'],
          body: datas['body'],
          author: datas['author'],
              chatroom: datas['chatroom'],
              file: datas['file']));
        });

    print(newdata.length);
        questionlist = [];
        questionlist = newdata;
        print(questionlist.length);
        return questionlist;


  }



  Future<http.Response> Vote(int reply) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    String toks = token.getString("Token");
    String url = "https://api.studentcandy.com/popsyman/course/likeresponse/$reply";

        return http.post(url, headers: {"Authorization": "Token $toks"});
  }



  Future<http.Response> GetResponse(int question) async {
    SharedPreferences token = await SharedPreferences.getInstance();
    String toks = token.getString("Token");

    String url = "https://api.studentcandy.com/popsyman/course/getreplies/$question";

    return http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Token $toks',
    }).then((response){
      if(response.statusCode == 200){
        List data = jsonDecode(response.body);
        List<Replies> newdata = [];
        data.forEach((obj) {
          newdata.add(Replies(
            id: obj['id'],
            body: obj['body'],
            file: obj['file'],
            author: obj['author'],
            question: obj['question'],
            votes: obj['votes'],
          ));
        });

        replieslist = [];
        replieslist = newdata;

        return response;
      }else{

        return response;
      }

    });


  }
}

class Course {
  int id;
  bool certified;
  String description;
  String moduleName;
  String thumbnail;
  String faculty;
  String module_code;
  String university;
  int enrolled;
  Map<String, Object> meta;
  Map<String, Object> meta2;
  String introduct_vid;
  int level;
  bool paid;
  Map<String, Object> tutor;

  Course(
      {@required this.id,
        @required this.meta,
        @required this.meta2,
      @required this.certified,
        @required this.description,
      @required this.moduleName,
      @required this.enrolled,
      @required this.faculty,
        @required this.module_code,
      @required this.level,
      @required this.introduct_vid,
      @required this.paid,
      @required this.thumbnail,
      @required this.university,
      @required this.tutor});
}

class Chapter {
  int id;
  String description;
  int length;
  double price;
  int likes;
  Map <String,dynamic> tutor;
  Map <String,dynamic> course;
  int reviews;
  String name;

  Chapter(
      {@required this.id,
      @required this.description,
      @required this.length,
        @required this.price,
        @required this.tutor,
        @required this.course,
        @required this.likes,
        @required this.reviews,
      @required this.name});
}

class Content {
  final Map<String, dynamic> chapter;
  final String content_file;
  final String content_type;
  final String name;

  Content(
      {@required this.name,
      @required this.chapter,
      @required this.content_file,
      @required this.content_type});
}

class Questions {
  final int id;
  final String body;
  final String file;
  final Map<String, dynamic> author;
  final Map<String, dynamic> chatroom;

  Questions(
      {@required this.id,
      @required this.body,
      @required this.file,
      @required this.author,
      @required this.chatroom});
}

class Replies {
  final int id;
  final String body;
  final String file;
  final Map<String, dynamic> author;
  final Map<String, dynamic> question;
  final int votes;

  Replies(
      {@required this.id,
      @required this.body,
      @required this.file,
      @required this.question,
      @required this.author,
      @required this.votes});
}

class ChapterComment{

  final int id;
  final Map<String,dynamic> commenter;
  final Map<String,dynamic> chapter;
  final String body;

  ChapterComment({
    @required this.id,
    @required this.commenter,
    @required this.chapter,
    @required this.body,
  });

}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';



class EditCourseScreen extends StatefulWidget {
  static const routeName = "/editcourse";

  @override
  _EditCourseScreenState createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  InAppWebViewController webcontroller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    String tok = data['token'][1];

    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          onLoadStop: (InAppWebViewController controller, String helo) {
            setState(() {
              isLoading = false;
            });
          },

          initialUrl: "https://www.studentcandy.com/admin/tutor/course/createcourse",
          initialHeaders: {
            'Content-type': 'application/json',
            'Authorization': 'Token $tok'
          },
          onWebViewCreated: (InAppWebViewController controller) {
            webcontroller = controller;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: isLoading == false
            ? Icon(Icons.home)
            : CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
        backgroundColor: Colors.pink[500],
      ),
    );
  }
}

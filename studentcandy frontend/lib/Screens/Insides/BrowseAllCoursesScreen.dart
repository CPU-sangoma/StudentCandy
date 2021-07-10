import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class BrowseAllCourses extends StatefulWidget {
  static String routeName = "/browsecourses";
  @override
  _BrowseAllCoursesState createState() => _BrowseAllCoursesState();
}

class _BrowseAllCoursesState extends State<BrowseAllCourses> {
  InAppWebViewController webcontroller;
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrl: "https://www.studentcandy.com/browse",
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {});
          },
          onLoadStop: (InAppWebViewController controller, String helo) {
            setState(() {
              isLoading = false;
            });
          },
          onWebViewCreated: (InAppWebViewController controller) {
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


import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';



class EditProfileScreen extends StatefulWidget {
  static const routeName = "/editprofile";

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  InAppWebViewController webcontroller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    String tok = data['token'][1];
    String type = data['token'][0];
    String url;

    if(type == "Tutor"){
      url = "https://www.studentcandy.com/admin/tutor/profile";
    }else{
      url = "https://www.studentcandy.com/admin/student/profile";
    }


    return Scaffold(
        body: SafeArea(
          child: InAppWebView(
            onLoadStop: (InAppWebViewController controller, String helo) {
              setState(() {
                isLoading = false;
              });
            },
            initialUrl: url,
            initialHeaders: {
              'Content-type': 'application/json',
              'Authorization': 'Token $tok',
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

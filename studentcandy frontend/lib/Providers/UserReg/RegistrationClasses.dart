import 'dart:convert';
import 'package:aceitflutter/Screens/Registration/Login_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';

class UserReg with ChangeNotifier{
  String userName;
  String email;
  String account;
  String school;
  String password;
  String confirmPassword;

  UserReg(
      {@required this.userName,
      @required this.email,
      @required this.account,
      @required this.school,
      @required this.password,
      @required this.confirmPassword});


  Future<http.Response> signup() async{

  const String url = "https://api.studentcandy.com/popsyman/auth/register";

  Map body = {
    "email": this.email,
    "username": this.userName,
    "user_type": this.account,
    "password": this.password,
    "password2": this.confirmPassword,
    "university_college": this.school,
  };

  return http.post(url,body: jsonEncode(body),headers:{
    "Content-type": "application/json",
  });

  }

  Future<http.Response> logIn(BuildContext context) async{

    SharedPreferences token = await SharedPreferences.getInstance();
    SharedPreferences type = await SharedPreferences.getInstance();

    const String url = "https://api.studentcandy.com/popsyman/auth/login";

    Map<String,String> body ={

      "username": this.userName,
      "password": this.password,
    };

    return http.post(url,body: jsonEncode(body),headers: {
      "Content-type": "application/json"
    });





  }
}

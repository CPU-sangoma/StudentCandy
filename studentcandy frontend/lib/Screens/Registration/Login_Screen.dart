import 'dart:convert';

import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';
import 'package:aceitflutter/Screens/Insides/My_courses_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aceitflutter/Screens/Registration/Signup_Screen.dart';
import 'package:aceitflutter/Providers/UserReg/RegistrationClasses.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordNode = FocusNode();
  bool isLoading = false;
  final _loginformKey = GlobalKey<FormState>();
  var user = UserReg(
      account: "",
      confirmPassword: "",
      email: "",
      password: "",
      school: "",
      userName: "");

  @override
  void dispose() {
    _passwordNode.dispose();
    super.dispose();
  }

  Future<http.Response> _savelogin()async{
    SharedPreferences token = await SharedPreferences.getInstance();

    final isvalid = _loginformKey.currentState.validate();
    if (isvalid) {
      setState(() {
        isLoading= true;
      });
      _loginformKey.currentState.save();
      return user.logIn(context).then((response){

        var res =  jsonDecode(response.body);

        if(response.statusCode == 200){
          setState(() {
            isLoading = false;
          });
          token.setString('Token', res['token']);
          token.setString('Type', res['user_type']);
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (Route<dynamic> route) => false);
        }else{
          setState(() {
            isLoading = false;
          });
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text("Your username and or password may be incorrect, please make sure you enter correct credentials"),
                );
              }
          );
        }



      });
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var MQ = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: (MQ.size.height - MQ.padding.top) * 0.36,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.lock,
                        size: 50.0,
                        color: Colors.pink[500],
                      ),
                    ),
                    Text(
                      "Login Screen",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.brown[500],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: (MQ.size.height - MQ.padding.top) * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Form(
                    key: _loginformKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: isLoading == false?Icon(
                              Icons.person,
                              color: Colors.yellow[700],
                            ): CircularProgressIndicator(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.pink[500],
                                  width: 3.0),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            labelText: "Username",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber)),
                          ),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_passwordNode);
                          },
                          onSaved: (value) {
                            user = UserReg(
                              userName: value,
                              school: user.school,
                              password: user.password,
                              email: "",
                              confirmPassword: "",
                              account: "",
                            );
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "cant leave the email field empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "cant leave password field empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: isLoading == false? Icon(
                                Icons.lock,
                                color: Colors.yellow[700],
                              ): CircularProgressIndicator(),
                              labelText: "Password",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.pink[500],
                                    width: 3.0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                          focusNode: _passwordNode,
                          onSaved: (value) {
                            user = UserReg(
                              userName: user.userName,
                              school: user.school,
                              password: value,
                              email: "",
                              confirmPassword: "",
                              account: "",
                            );
                          },
                          onFieldSubmitted: (_) {
                            _savelogin();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.brown[500],
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow[500],
                      blurRadius: 30.0,
                      spreadRadius: 3.0,
                    )
                  ]),
              width: MQ.size.width * 0.5,
              child: RaisedButton.icon(
                onPressed: () {
                  _savelogin();
                },
                color: Colors.yellow[500],
                icon: Icon(
                  Icons.done,
                  color: Colors.brown[700],
                ),
                label: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.brown[700]),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SignupScreen.routeName);
              },
              child: Text(
                "Don't have an account? signup",
                style: TextStyle(
                    color: Colors.brown[900], fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}

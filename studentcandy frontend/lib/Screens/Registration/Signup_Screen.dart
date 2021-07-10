import 'dart:convert';

import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';
import 'package:aceitflutter/Screens/Registration/Login_Screen.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aceitflutter/Providers/UserReg/RegistrationClasses.dart';
import 'package:aceitflutter/Widgets/BackgroundEffect.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = "/signupScreen";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupform = GlobalKey<FormState>();
  final _emailnode = FocusNode();
  final _nameNode = FocusNode();
  final _accountnode = FocusNode();
  final _varsitynode = FocusNode();
  final _password = FocusNode();
  final _conpassword = FocusNode();
  var _password1C = TextEditingController();

  var user = UserReg(
    account: "",
    confirmPassword: "",
    email: "",
    password: "",
    school: "",
    userName: "",
  );
  String dropDownVal = "Student";

  bool isloading1 = false;

  @override
  void dispose() {
    _emailnode.dispose();
    _nameNode.dispose();
    _accountnode.dispose();
    _varsitynode.dispose();
    _password.dispose();
    _conpassword.dispose();
    _password1C.dispose();
    super.dispose();

  }

  String _emptyVal(String val) {
    if (val.isEmpty) {
      return "make sure this field is not empty";
    }
    return null;
  }

  void _signUp() async{
    SharedPreferences token = await SharedPreferences.getInstance();
    final isValid = _signupform.currentState.validate();
    if (isValid) {
      setState(() {
        isloading1 = true;
      });
      _signupform.currentState.save();
      user.signup().then((res){
        var data = jsonDecode(res.body);
        if(res.statusCode == 200){
          setState(() {
            isloading1 = false;
          });
          if(data['response'] == "successfully registered"){
            token.setString('Token', data['token']);
            token.setString('Type', data['type']);
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (Route<dynamic> route) => false);
          }else if(data['username'][0] == "A user with that username already exists."){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Text("That username already exists"),
                  );
                }
            );
          }else{
            print(data['username']);
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Text("1 Something went wrong, Try using our website to sign up. www.studentcandy.com"),
                  );
                }
            );
          }
        }else{
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text("Something went wrong, check your internet connection or try using our website to sign up. www.studentcandy.com"),
                );
              }
          );
        }
      });

    }

  }

  String passwordCheck(String no1, String no2){

    if(no1 != no2){
      return "password 1 does not match password Confirmation keng ka wena?";
    }
    return null;

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
                          Icons.check_circle,
                          size: 50.0,
                          color: Colors.pink[500],
                        ),
                      ),
                      Text(
                        "Signup",
                        style: TextStyle(
                          color: Colors.brown[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: (MQ.size.height - MQ.padding.top) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Form(
                        key: _signupform,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.pink[500],
                                      width: 3.0
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                prefixIcon: isloading1 == false ? Icon(Icons.person,color:Colors.yellow[700] ):CircularProgressIndicator(),
                                labelText: "User Name",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber)),
                              ),
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                user = UserReg(
                                  userName: value,
                                  school: user.school,
                                  password: user.password,
                                  email: user.email,
                                  confirmPassword: user.confirmPassword,
                                  account: user.account,
                                );
                                FocusScope.of(context).requestFocus(_emailnode);
                              },
                              validator: (value) {
                                return _emptyVal(value);
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Colors.pink[500],
                                        width: 3.0
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                  prefixIcon: isloading1 == false? Icon(Icons.email,color:Colors.yellow[700]):CircularProgressIndicator(),
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.amber))),
                              textInputAction: TextInputAction.next,
                              focusNode: _emailnode,
                              onSaved: (value) {
                                user = UserReg(
                                  userName: user.userName,
                                  school: user.school,
                                  password: user.password,
                                  email: value,
                                  confirmPassword: user.confirmPassword,
                                  account: user.account,
                                );
                                FocusScope.of(context).requestFocus(_accountnode);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "field can not be left empty";
                                }
                                if (!value.contains("@")) {
                                  return "Make sure you enter a valid email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            DropdownButtonFormField(
                              elevation: 5,
                              onSaved: (Val){
                                user = UserReg(
                                  userName: user.userName,
                                  school: user.school,
                                  password: user.password,
                                  email: user.email,
                                  confirmPassword: user.confirmPassword,
                                  account: Val,
                                );
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Colors.pink[500],
                                        width: 3.0
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                  prefixIcon:isloading1 == false ? Icon(Icons.person,color:Colors.yellow[700]): CircularProgressIndicator(),
                                  labelText: "Account Type",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.amber))) ,
                              value:dropDownVal,
                              icon: Icon(Icons.arrow_downward,color: Colors.yellow[700]),
                              hint: Text(
                                "Account Type"
                              ),
                              onChanged: (Val){
                                setState(() {
                                  dropDownVal = Val;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text("Student"),
                                  value: "Student"
                                ),
                                DropdownMenuItem(
                                  child: Text("Tutor"),
                                  value: "Tutor",
                                )
                              ]
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.pink[500],
                                      width: 3.0
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                prefixIcon:isloading1 == false ? Icon(Icons.school,color:Colors.yellow[700]): CircularProgressIndicator(),
                                labelText: "varsity",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber)),
                              ),
                              focusNode: _varsitynode,
                              onSaved: (value) {
                                user = UserReg(
                                  userName: user.userName,
                                  school: value,
                                  password: user.password,
                                  email: user.email,
                                  confirmPassword: user.confirmPassword,
                                  account: user.account,
                                );
                                FocusScope.of(context).requestFocus(_password);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return " field cant be left empty, make sure all fields are filled up";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Colors.pink[500],
                                        width: 3.0
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.7),
                                  prefixIcon:isloading1 == false ? Icon(Icons.lock,color:Colors.yellow[700],): CircularProgressIndicator(),
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.amber))),
                              focusNode: _password,
                              onSaved: (value) {
                                user = UserReg(
                                  userName: user.userName,
                                  school: user.school,
                                  password: value,
                                  email: user.email,
                                  confirmPassword: user.confirmPassword,
                                  account: user.account,
                                );
                                FocusScope.of(context).requestFocus(_conpassword);
                              },
                              controller: _password1C,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return " field cant be left empty, make sure all fields are filled up";
                                }
                                if (value.length <= 7) {
                                  return "password too short, 8 digits minimum";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.pink[500],
                                      width: 3.0
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                prefixIcon:isloading1 == false ? Icon(Icons.lock,color: Colors.yellow[700],):CircularProgressIndicator(),
                                labelText: "Confirm Password",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber)),
                              ),
                              focusNode: _conpassword,
                              onSaved: (value) {
                                user = UserReg(
                                  userName: user.userName,
                                  school: user.school,
                                  password: user.password,
                                  email: user.email,
                                  confirmPassword: value,
                                  account: user.account,
                                );
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return " field cant be left empty, make sure all fields are filled up";
                                }
                                if(_password1C.text != value){
                                  return "Passwords don't match";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            Container(    decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow[500],
                    blurRadius: 30.0,
                    spreadRadius: 3.0,

                  )
                ]
            ),
                  width: MQ.size.width * 0.5,
                  child: RaisedButton.icon(
                    elevation: 7.0,
                    onPressed: () {
                      _signUp();
                    },
                    color: Colors.yellow[500],
                    icon: Icon(Icons.done,color: Colors.brown[500],),
                    label: Text(
                      "Sign-Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.brown[500]),
                    ),
                  ),
                ),

              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text(
                  "Already Have an Account",
                  style: TextStyle(
                      color: Colors.brown[500], fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ),
    );
  }
}

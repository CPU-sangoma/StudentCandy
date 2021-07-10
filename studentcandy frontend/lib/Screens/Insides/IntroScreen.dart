import 'package:aceitflutter/Screens/Insides/HomePage_Screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aceitflutter/Screens/Registration/Signup_Screen.dart';

class IntroScreen extends StatefulWidget {
  static String routeName = "/introscreenroute";
  @override
  _IntroScreenState createState() => _IntroScreenState();
}
class _IntroScreenState extends State<IntroScreen> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.asset("Images/Videos.png",height: 200.0,),
          title: "Online education made easy",
          body: "Search for your specific module code, choose from the chapter's you need to watch then start learning",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          )),
      PageViewModel(
          image: Image.asset("Images/Community.png",height: 200.0,),
          title: "Live Chatrooms",
          body: "Join a community of other students in your class to ask for solutions to those difficult problem sets you can't seem to understand in our interactive chatrooms",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          )),
      PageViewModel(
          image: Image.asset("Images/Tutors.png",height: 200.0,),
          title: "Quality Tutors",
          body: "All tutors on this platform got atleast 65% on the module they are teaching so you can trust that you are in capable hands.",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          )),
      PageViewModel(
          image: Image.asset("Images/Buy.png",height: 200.0,),
          title: "Buy Watch Learn",
          body: "Buy only the chapters you need at an amazingly affordable price. You also get life time access to the chapter you bought",
          decoration: const PageDecoration(
            pageColor: Colors.white,
          ))
    ];
  }
  Future<void> checkkauth()async{

    SharedPreferences token = await SharedPreferences.getInstance();

    if(token.getString('Token').isNotEmpty){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    checkkauth();
    return Scaffold(
      backgroundColor: Colors.orange[700],
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: getPages(),
          dotsDecorator: DotsDecorator(
              color: Colors.yellow,
            activeColor: Colors.deepOrange,
          ),
          showNextButton: true,
          done: Text("Got it"),
          onDone: () {
            Navigator.of(context).pushNamed(SignupScreen.routeName);
          },
        ),
      ),
    );
  }
}

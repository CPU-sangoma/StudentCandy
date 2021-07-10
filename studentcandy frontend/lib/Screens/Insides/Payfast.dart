import 'package:aceitflutter/Providers/courseProviders/Courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';

class PayfastScreen extends StatefulWidget {
  static const routeName = "/payfastscreen";

  @override
  _PayfastScreenState createState() => _PayfastScreenState();
}

class _PayfastScreenState extends State<PayfastScreen> {
  InAppWebViewController webcontroller;
  bool isLoading = true;


  String SplitInfo(int id){
    Map data1 = {
      "split_payment": {"merchant_id": id, "percentage": 60}
    };
    return jsonEncode(data1);
  }


  String _loadHTML({double amount,String name,String description,int merchantID,int courseid,int chapterid}) {
    return '''
      <html>
          <body onload="document.f.submit();">
          <form id="f" name="f"  method="POST" action="https://www.payfast.co.za/eng/process">
            <input type="hidden" name="merchant_id" value="16197712">
            <input type="hidden" name="merchant_key" value="zvx18xv18dvzm">
            <input type="hidden" name="return_url" value="https://www.studentcandy.com/course/$courseid/chapter/$chapterid/enrolled">
            <input type="hidden" name="cancel_url" value="https://www.studentcandy.com/course/$courseid">
            <input type="hidden" name="amount" value=$amount>
            <input type="hidden" name="item_name" value=$name>
            <input type="hidden" name="item_description" value="$description">
            <input type="hidden" name="setup" value=${SplitInfo(merchantID)}>
          </form>
           </body>
      </html>
    ''';
  }

  @override
  @override
  Widget build(BuildContext context) {
    Map<String,Chapter> chapInfo = ModalRoute.of(context).settings.arguments as Map<String,Chapter>;
    print(chapInfo['data'].course['id']);
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrl: Uri.dataFromString(_loadHTML(amount: chapInfo['data'].price, name: chapInfo['data'].name,description: chapInfo['data'].description,merchantID: int.parse(chapInfo['data'].tutor['merchantId']),courseid: chapInfo['data'].course['id'],chapterid: chapInfo['data'].id),mimeType: 'text/html',).toString(),
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_tokenauth/common/apifunctions/requestLoginAPI.dart';
import 'package:splash_tokenauth/common/functions/showDialogSingleButton.dart';
import 'package:splash_tokenauth/common/platform/platformScaffold.dart';
import 'package:splash_tokenauth/common/widgets/basicDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

const URL = "http://www.google.com";

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _welcomeString = "";

  Future launchURL(String url) async {
    if(await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      showDialogSingleButton(context, "Unable to reach your website.", "Currently unable to reach the website $URL. Please try again at a later time.", "OK");
    }
  }

  @override
  void initState() {
    super.initState();
    _saveCurrentRoute("/LoginScreen");
  }

  _saveCurrentRoute(String lastRoute) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('LastScreenRoute', lastRoute);
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer();
    return WillPopScope(
      onWillPop: () {
        if(Navigator.canPop(context)) {
          Navigator.of(context).pushNamedAndRemoveUntil('/HomeScreen', (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushReplacementNamed('/HomeScreen');
        }
      },
      child:


      PlatformScaffold(
        drawer: BasicDrawer(),
        appBar:  AppBar(
          title: Text("LOGIN",
            style: TextStyle(fontSize: 30.0, color: Colors.black,),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        backgroundColor: Colors.white,

        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: ListView(
              children: <Widget>[
                Container(alignment: Alignment.topCenter,
                    child: Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 15.0),
                      child: Text("TestApp", style: TextStyle(fontSize: 40.0, color: Colors.black),),
                    )
                ),

                Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 78.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'This is the logon screen. If you would like to search for something you can go to ',
                          style: new TextStyle(fontSize: 20.0, color: Colors.black, ),
                        ),
                        TextSpan(
                          text: 'Google',
                          style: TextStyle(fontSize: 20.0, color: Colors.blueAccent, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchURL(URL);
                            },
                        ),
                        TextSpan(
                          text: '. Normally this link would probably be to the applications corporate website.',
                          style: new TextStyle(fontSize: 20.0, color: Colors.black, ),
                        ),
                      ],
                    ),
                  ),
                ),


                Text("Username", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: "Use your web  User name",
                    ),
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                  child: Text("Password", style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Your password, keep it secret, keep it safe.',
                    ),
                    obscureText: true,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                  child: Container(height: 65.0,
                    child: RaisedButton(
                        onPressed: () {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          requestLoginAPI(context, _userNameController.text, _passwordController.text);
                        },
                        child: Text("LOGIN",
                            style: TextStyle(color: Colors.white,
                                fontSize: 22.0)
                        ),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


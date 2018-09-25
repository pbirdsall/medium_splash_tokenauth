import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splash_tokenauth/common/platform/platformScaffold.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() =>  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDuration = 2;

  startTime() async {
    return Timer(
        Duration(seconds: splashDuration),
            () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.of(context).pushReplacementNamed('/LoginScreen');
        }
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer();

    return PlatformScaffold(drawer: drawer,
        body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: <Widget>[
                Expanded(child:
                Container(decoration: BoxDecoration(color: Colors.black),
                  alignment: FractionalOffset(0.5, 0.3),
                  child:
                  Text("TestApp", style: TextStyle(fontSize: 40.0, color: Colors.white),),
                ),
                ),
                Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child:
                  Text("© Copyright Statement 2018", style: TextStyle(fontSize: 16.0, color: Colors.white,),
                  ),
                ),
              ],
            )
        )
    );
  }
}
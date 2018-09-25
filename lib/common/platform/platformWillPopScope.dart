import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlatformWillPopScope extends StatelessWidget{

  final Key key;
  final Widget child;
  final WillPopCallback onWillPop = () {return Future.value(false);};

  final EdgeInsetsGeometry paddingExternal = EdgeInsets.all(0.0);

  PlatformWillPopScope({
    this.key,
    this.child,
    onWillPop
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Platform.isIOS ?
    Padding(padding: paddingExternal == null ? EdgeInsets.all(0.0) : paddingExternal,
      child: child,
    )
        :
    WillPopScope(key: key,
        child: child,
        onWillPop: onWillPop);
  }
}

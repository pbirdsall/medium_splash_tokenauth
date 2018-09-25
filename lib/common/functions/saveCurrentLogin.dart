

import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_tokenauth/model/json/loginModel.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();


  var user;
  if ((responseJson != null && !responseJson.isEmpty)) {
    user = LoginModel.fromJson(responseJson).userName;
  } else {
    user = "";
  }
  var token = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).token : "";
  var email = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).email : "";
  var pk = (responseJson != null && !responseJson.isEmpty) ? LoginModel.fromJson(responseJson).userId : 0;

  await preferences.setString('LastUser', (user != null && user.length > 0) ? user : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
  await preferences.setString('LastEmail', (email != null && email.length > 0) ? email : "");
  await preferences.setInt('LastUserId', (pk != null && pk > 0) ? pk : 0);

}
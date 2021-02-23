


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapptask/Constant/RoutesConstants.dart';
import 'package:weatherapptask/Models/LoginModel.dart';
import 'package:weatherapptask/Models/LoginModelResponse.dart';
import 'package:weatherapptask/Survices/GetWeatherApi.dart';
import 'package:weatherapptask/Utlis/Common.dart';
import 'package:weatherapptask/Widget/Allert.dart';

Future<String> LoginApi(LoginModel loginModel, BuildContext context)async{
  Dio dio = Dio();
  Response response;
  var body = json.encode(loginModel.toJson());
  response = await dio.post("http://multi-choice.org/api/Authenticate/login", data: body);
  if (response.statusCode == 200) {
    if(response.data["status"]=="Success"){
      print('UserLogedin');
      SharedPreferences isLogedIn =
      await SharedPreferences.getInstance();
      isLogedIn.setBool(Common.isLogin, true);


      LoginModelResponse loginModelResponse  =LoginModelResponse.fromJson(response.data);

     await GetWeatherApi(loginModelResponse.data.token,context).whenComplete(() {
       WidgetsFlutterBinding.ensureInitialized();
       Navigator.of(context)
           .popAndPushNamed(RoutesConstants.homePage);

     });


    }else{
      onCustomAnimationAlertPressed(context,response.data["status"],response.data["message"]);
    }
  }if(response.data["status"]=="Error") {
    onCustomAnimationAlertPressed(context,response.data["status"], response.data["message"]);

  }


}

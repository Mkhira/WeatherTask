


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:weatherapptask/Models/RegisterModel.dart';
import 'package:weatherapptask/Models/LoginModel.dart';
import 'package:weatherapptask/Provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/Widget/Allert.dart';
Future<String> RegisterApi(
    {RegisterModel registerModel,
    String name,
    String password,
    BuildContext context})async{
  Dio dio = Dio();
  Response response;
  var body = json.encode(registerModel.toJson());
  print(body);
  response = await dio.post("http://multi-choice.org/api/Authenticate/register", data: body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    if(response.data["status"]=="Success"){
      print("User Created");
      var provider = Provider.of<MainProvider>(context,listen: false);
      LoginModel body = LoginModel();
      provider.userLogin(password: password,context: context,name: name,body: body);
    }else{
      onCustomAnimationAlertPressed(context,response.data["status"],response.data["message"]);
    }
  }else{
    onCustomAnimationAlertPressed(context,response.data["status"], response.data["message"]);

  }


}



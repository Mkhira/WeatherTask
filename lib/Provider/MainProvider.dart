
import 'package:weatherapptask/Models/RegisterModel.dart';
import 'package:weatherapptask/Models/LoginModel.dart';
import 'package:weatherapptask/Models/WeatherModel.dart';
import 'package:weatherapptask/Survices/SignUpServices.dart';
import 'package:weatherapptask/Survices/LoginSurvices.dart';


import 'package:flutter/cupertino.dart';
class MainProvider extends ChangeNotifier{

  List<WaetherResponseModel> waetherResponseModel =[];

  Future<String> futureRegister;
  registerUser(RegisterModel body , String name ,String email , String password , BuildContext context)async{
    print('register Start');
    body.email = email;
     body.username = name;
     body.password = password;
     futureRegister   = RegisterApi(name: name,context:context,password: password,registerModel: body );
     notifyListeners();
  }



  Future<String> futureLogin;
  userLogin(
      {LoginModel body,
      String name,
      String password,
      BuildContext context})async{
    body.username = name;
    body.password = password;
    futureLogin   = LoginApi(body,context);
    notifyListeners();
  }

  }
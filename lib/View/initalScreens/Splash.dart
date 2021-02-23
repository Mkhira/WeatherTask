import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/Constant/RoutesConstants.dart';
import 'package:weatherapptask/Models/LoginModel.dart';
import 'package:weatherapptask/Provider/MainProvider.dart';
import 'package:weatherapptask/Survices/LoginSurvices.dart';
import 'package:weatherapptask/Utlis/Common.dart';
import 'package:weatherapptask/Widget/Allert.dart';
import 'package:weatherapptask/Widget/app_text.dart';
import 'package:weatherapptask/helpers/Util.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    // provider.initialize();

    startTime();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: _scaler.getWidth(100),
        height: _scaler.getHeight(100),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: _scaler.getHeight(8),
            ),
            AppText(
              text: "Welcome",
              style: AppTextStyle.title,
            ),
            SizedBox(
              height: _scaler.getHeight(35),
            ),
            AppText(
              text: "Weather App Task",
              style: AppTextStyle.medium,
            ),
          ],
        ),
      ),
    );
  }


  startTime() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      onCustomAnimationAlertPressed(context,"Error", "Please check your connection");
      startTime();
    }else{
    var _duration = new Duration(seconds: 3);
    WidgetsFlutterBinding.ensureInitialized();
    return new Timer(_duration, navigationPage);
  }}
  Future<void> navigationPage() async {



    Future<String> future;
    bool status = await Common.getIsLogin();
    String named = await Common.getName();
    String pass = await Common.getPassword();
    LoginModel body = LoginModel();
    body.username = named;
    body.password = pass;
    if(status == true){
      future =  LoginApi(body,context);
    }else{
      Navigator.of(context).popAndPushNamed(RoutesConstants.signIn);

    }
  }

}


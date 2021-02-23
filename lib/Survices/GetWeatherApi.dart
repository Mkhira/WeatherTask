


import 'package:dio/dio.dart';
import 'package:weatherapptask/Models/WeatherModel.dart';
import 'package:weatherapptask/Provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:weatherapptask/Widget/Allert.dart';

Future<String> GetWeatherApi( String token,BuildContext context)async{
  Dio dio = Dio();
  Response response;
  // var body = json.encode(loginModel.toJson());

  response = await dio.get("http://multi-choice.org/api/WeatherForecast",options: Options(
    headers:{
      "Authorization":"Bearer $token"
    }
  ));

  if(response.statusCode ==200){
    var provider = Provider.of<MainProvider>(context,listen: false);
    print('succes');
     provider.waetherResponseModel.clear();
    print(response.data.length);
    for(int i =0 ; i < response.data.length ;i++){
         provider.waetherResponseModel.add(WaetherResponseModel(date: response.data[i]["date"],summary:response.data[i]["summary"] ,temperatureC:response.data[i]["temperatureC"] ,temperatureF:response.data[i]["temperatureF"] ));
    }
    print(provider.waetherResponseModel[1].date);
    print(provider.waetherResponseModel[2].date);
    print(provider.waetherResponseModel[3].date);
  }else{
    onCustomAnimationAlertPressed(context,response.data["status"], response.data["message"]);

  }


}

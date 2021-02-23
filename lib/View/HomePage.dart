


import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/Constant/ColorConistant.dart';
import 'package:weatherapptask/Provider/MainProvider.dart';
import 'package:weatherapptask/Widget/app_text.dart';
import 'package:weatherapptask/Widget/AppButton.dart';
import 'package:weatherapptask/Utlis/Common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weatherapptask/Constant/RoutesConstants.dart';

class HomePage extends StatelessWidget {
  ScreenScaler scaler;
  List<String> keys =["Date","Summary","TemperatureC","TemperatureF"];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context,listen: false);
    if (scaler == null) scaler = ScreenScaler()..init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.backGroundPage,
        title: AppButton(text: "Logout",height: 5,
          width: 30,
          mainColor: ColorConstants.darkBlueColor,
          borderColor:ColorConstants.darkBlueColor ,
          textEnabledColor:ColorConstants.mainColor ,
          onPressed: ()async{

            SharedPreferences isLogedIn =
            await SharedPreferences.getInstance();
            isLogedIn.setBool(Common.isLogin, false);
            Navigator.of(context).pushReplacementNamed(RoutesConstants.signIn);

          },
          enabled: true,
        ),

      ),
      backgroundColor: ColorConstants.backGroundPage,
      body: SingleChildScrollView(
        child:Column(children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.waetherResponseModel.length,
            itemBuilder:(context,x){
              return Padding(

                padding: scaler.getPaddingLTRB(2, 2, 2, 2),
                child: Card(
                  elevation: 4,
                  margin: scaler.getMarginAll(2),
                  color: ColorConstants.grey.withOpacity(.9),
                     shape: RoundedRectangleBorder(
                       side: BorderSide(color: ColorConstants.mainColor,width: 2.5),
                       borderRadius: BorderRadius.circular(15)
                     ),
                  child: Container(
                    margin: scaler.getMarginAll(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)

                    ),
                    child: Column(
                      children: [
                        SizedBox(height: scaler.getHeight(2),),
                        displayWidget(vKey: "Date",value: "${DateTime.parse(provider.waetherResponseModel[x].date)}",),
                        SizedBox(height: scaler.getHeight(1),),

                        displayWidget(vKey: "TemperatureC",value: "${provider.waetherResponseModel[x].temperatureC}",),
                        SizedBox(height: scaler.getHeight(1),),

                        displayWidget(vKey: "TemperatureF",value: "${provider.waetherResponseModel[x].temperatureF}",),
                        SizedBox(height: scaler.getHeight(1),),

                        displayWidget(vKey: "Summary",value: "${provider.waetherResponseModel[x].summary}",),
                        SizedBox(height: scaler.getHeight(2),),

                      ],
                    ),
                  ),
                ),
              );
            } ,
          )
        ],),
      ),
    ));
  }
}

class displayWidget extends StatelessWidget {
  displayWidget({this.value,this.vKey});
  final String vKey;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 7,),
        AppText(text: "$vKey: ",color: ColorConstants.darkBlueColor,style: AppTextStyle.medium,),
        AppText(text: " $value",color: ColorConstants.mainColor,style: AppTextStyle.regular,),
      ],
    );
  }
}

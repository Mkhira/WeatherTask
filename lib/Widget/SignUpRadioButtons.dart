
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:weatherapptask/Constant/ColorConistant.dart';

import 'app_text.dart';

class RadioButtonSignUp extends StatefulWidget {
  RadioButtonSignUp({this.gander});
  bool gander = false;
  @override
  _RadioButtonSignUpState createState() => _RadioButtonSignUpState();
}

class _RadioButtonSignUpState extends State<RadioButtonSignUp> {
  ScreenScaler scaler;
  int groub =0;
  @override
  Widget build(BuildContext context) {
    if (scaler == null) scaler = ScreenScaler()
      ..init(context);


    return Container(
      child: Column(children: [
        Row(
          children: <Widget>[
            Container(
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.white,

                  shape: BoxShape.circle
              ),
              child: Radio(
                  focusColor: ColorConstants.mainColor,
                  activeColor: ColorConstants.mainColor,

                  value: 1,
                  groupValue: groub,
                  onChanged: (val) {
                    setState(() {
                      groub = val;
                      widget.gander =true;

                    });
                  }),
            ),
            SizedBox(width: scaler.getWidth(2),),

            AppText(text: "Male")
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.white,

                  shape: BoxShape.circle
              ),
              child: Radio(
                  value: 2,
                  focusColor: ColorConstants.mainColor,
                  activeColor: ColorConstants.mainColor,
                  groupValue: groub,
                  onChanged: (val) {
                    setState(() {
                      groub = val;
                      widget.gander =true;


                    });
                  }),
            ),
            SizedBox(width: scaler.getWidth(2),),

            AppText(text: "Female")
          ],
        ),
      ],),
    );
  }
}
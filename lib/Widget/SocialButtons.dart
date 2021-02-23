



import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_svg/svg.dart';

class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
           Container(
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.white,

               ),
             child: GestureDetector(
               child: Image(image: AssetImage("assets/facebook.png"),
                        fit: BoxFit.contain,
                        width: scaler.getWidth(10),
               ),
             ),
           ),
           SizedBox(width: scaler.getWidth(4),),
           Container(
             width: scaler.getWidth(10),
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.white,


               ),
             child: SvgPicture.asset("assets/google.svg",width: scaler.getWidth(10),),
           )
      ],
    );
  }
}

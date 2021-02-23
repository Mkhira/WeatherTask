



import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapptask/Constant/ColorConistant.dart';
import 'package:weatherapptask/Constant/RoutesConstants.dart';
import 'package:weatherapptask/Models/LoginModel.dart';
import 'package:weatherapptask/Provider/MainProvider.dart';
import 'package:weatherapptask/Utlis/Common.dart';
import 'package:weatherapptask/Widget/AppButton.dart';
import 'package:weatherapptask/Widget/SocialButtons.dart';
import 'package:weatherapptask/Widget/app_text.dart';
import 'package:weatherapptask/Widget/app_text_field.dart';
import 'package:weatherapptask/helpers/validations.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}
String userModelName = "userModelName";
class _SignInState extends State<SignIn> {
  ScreenScaler scaler;
  var nodes = List<FocusNode>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  bool isEmailValid = null;
  bool isPasswordValid = null;
  bool animation = false;

  String errorText = "";

  @override
  void initState() {
    nodes.add(FocusNode());
    nodes.add(FocusNode());

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus)
        validateName();
      else if (nameController.text.toString().isNotEmpty) {
        nameController.addListener(() {
          validateName();
        });
      }
    });

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus)
        validatePassword();
      else if (passwordController.text.toString().isNotEmpty) {
        passwordController.addListener(() {
          passwordController.removeListener(() {});
          validatePassword();
        });
      } else {
        passwordController.addListener(() {
          if (isPasswordValid != null && isPasswordValid) validatePassword();

          if (passwordController.text.toString().contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && passwordController.text.toString().length>=6 && passwordController.text.toString().contains(new RegExp(r'[A-Z]')) && passwordController.text.toString().contains(new RegExp(r'[a-z]')))
            setState(() {
              isPasswordValid = true;
            });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (scaler == null) scaler = ScreenScaler()..init(context);
    var provider = Provider.of<MainProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.backGroundPage,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: scaler.getMargin(0, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: AppText(
                          text: "Login",
                          style: AppTextStyle.title,
                          align: true,
                          color: ColorConstants.mainColor,
                        ),
                      ),
                      SizedBox(
                        height: scaler.getHeight(1),
                      ),
                      SizedBox(
                        height: scaler.getHeight(2),
                      ),
                      AppTextField(
                        hintText: 'User name',
                        inputType: TextInputType.emailAddress,
                        action: TextInputAction.next,
                        controller: nameController,
                        password: false,
                        valid: isEmailValid,
                        node: nodes[0],
                        nextNode: nodes[1],
                      ),
                      SizedBox(
                        height: scaler.getHeight(3),
                      ),
                      AppTextField(
                        hintText: "Password",
                        action: TextInputAction.done,
                        controller: passwordController,
                        password: true,
                        valid: isPasswordValid,
                        node: nodes[1],
                      ),
                      SizedBox(
                        height: scaler.getHeight(1),
                      ),
                      AppText(
                        text: errorText,
                        color: ColorConstants.red,
                      ),

                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                            padding: scaler.getPadding(1, 1),
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              text: "Forget Password",
                              style: AppTextStyle.medium,

                              color: Colors.white,
                            )),
                      ),


                      SizedBox(
                        height: scaler.getHeight(4),
                      ),
                      Align(
                        alignment: Alignment.center,

                        child: AppButton(
                          width: 100,
                          mainColor: ColorConstants.mainColor,
                          borderColor: ColorConstants.mainColor,
                          textEnabledColor: ColorConstants.grey,
                          onPressed: ()async{

                            animation = true;
                            SharedPreferences nameSahred =
                                await SharedPreferences.getInstance();
                            nameSahred.setString(Common.name, nameController.text.toString());


                            SharedPreferences pass =
                                await SharedPreferences.getInstance();
                            pass.setString(Common.password, passwordController.text.toString());
                            LoginModel body = LoginModel();
                           provider.userLogin(password: passwordController.text ,context: context,name: nameController.text,body:body );

                            setState(() {
                              animation = false;

                            });
                          },
                          text: "Login",
                          enabled: (isEmailValid != null && isEmailValid) &&
                              (isPasswordValid != null && isPasswordValid),
                        ),
                      ),
                      SizedBox(
                        height: scaler.getHeight(8),
                      ),
                      Container(
                          padding: scaler.getPadding(1, 1),
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            text: "Don't have account?",
                            style: AppTextStyle.medium,

                            color: Colors.white,
                          )),
                      SizedBox(
                        height: scaler.getHeight(1),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AppButton(
                          width: 100,
                          onPressed: (){

                            Navigator.of(context)
                            .popAndPushNamed(RoutesConstants.signUp);
                          },
                          text: "Sign Up",
                          enabled: true,
                          textEnabledColor: ColorConstants.mainColor,
                          borderColor: ColorConstants.mainColor,
                          mainColor: ColorConstants.backGroundPage ,
                        ),
                      ),
                      SizedBox(
                        height: scaler.getHeight(8),
                      ),

                      AppText(
                        text: "Or connect with:",
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: scaler.getHeight(3),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: SocialButtons(),
                      ),

                      SizedBox(
                        height: scaler.getHeight(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            animation == true?  Positioned(
              child: Container(
                  color: ColorConstants.grey.withOpacity(.5),
                  child: Center(child: Lottie.asset('animations/loader.json'))),
            ): Container(),
          ],
        ),
      ),
    );
  }


  validateName() {
    setState(() {
      isEmailValid =
          Validations.nameValidation(nameController.text.toString());

      errorText = !isEmailValid ? "Invalid user name" : "";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid =
          Validations.passwordValidation(passwordController.text.toString());
      errorText = !isPasswordValid ? "Invalid password" : "";
    });
  }
}

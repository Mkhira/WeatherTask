
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapptask/Constant/ColorConistant.dart';
import 'package:weatherapptask/Constant/RoutesConstants.dart';
import 'package:weatherapptask/Models/RegisterModel.dart';
import 'package:weatherapptask/Provider/MainProvider.dart';
import 'package:weatherapptask/Utlis/Common.dart';
import 'package:weatherapptask/Widget/AppButton.dart';
import 'package:weatherapptask/Widget/CountryMenu.dart';
import 'package:weatherapptask/Widget/SignUpRadioButtons.dart';
import 'package:weatherapptask/Widget/app_text.dart';
import 'package:weatherapptask/Widget/app_text_field.dart';
import 'package:weatherapptask/helpers/validations.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

String bookModelName = "bookModelName";
String userModelName = "userModelName";

class _SignUpState extends State<SignUp> {

  ScreenScaler scaler;
  var nodes = List<FocusNode>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  bool isNameValid = null;
  bool isPhoneValid = null;
  bool isEmailValid = null;
  bool isPasswordValid = null;
  bool isConfirmPasswordValid = null;
  bool animation = false;
  String errorText = "";
  String errorEmail = "";
  int groupValue = 0;
  bool gander =false;




  @override
  void initState() {

    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());
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
        validatePhone();
      else if (phoneController.text.toString().isNotEmpty &&(phoneController.text.toString().length >=10 && phoneController.text.toString().length <=11)) {
        phoneController.addListener(() {
          validatePhone();
        });
      }
    });
    nodes[2].addListener(() {
      if (!nodes[2].hasFocus)
        validateEmail();
      else if (emailController.text.toString().isNotEmpty) {
        emailController.addListener(() {
          validateEmail();
        });
      }
    });
    nodes[3].addListener(() {
      if (!nodes[3].hasFocus)
        validatePassword();
      else if (passwordController.text.toString().contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && passwordController.text.toString().length>=6 && passwordController.text.toString().contains(new RegExp(r'[A-Z]')) && passwordController.text.toString().contains(new RegExp(r'[a-z]'))){
        phoneController.addListener(() {
          validatePassword();
        });
      }
    });

    // nodes[3].addListener(() {
    //   if (!nodes[3].hasFocus)
    //     validatePassword();
    //   else if (passwordController.text.toString().isNotEmpty) {
    //     passwordController.addListener(() {
    //       passwordController.removeListener(() {});
    //       validatePassword();
    //     });
    //   } else {
    //     passwordController.addListener(() {
    //       if (isPasswordValid != null && isPasswordValid) validatePassword();
    //
    //       if (passwordController.text.toString().contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && passwordController.text.toString().length>=6 && passwordController.text.toString().contains(new RegExp(r'[A-Z]')) && passwordController.text.toString().contains(new RegExp(r'[a-z]')))
    //         setState(() {
    //           isPasswordValid = true;
    //         });
    //     });
    //   }
    // });
    nodes[4].addListener(() {
      if (!nodes[4].hasFocus)
        validateConfirmPassword();
      else if (confirmPasswordController.text.toString().isNotEmpty) {
        confirmPasswordController.addListener(() {
          confirmPasswordController.removeListener(() {});
          validateConfirmPassword();
        });
      } else {
        confirmPasswordController.addListener(() {
          if (isConfirmPasswordValid != null && isConfirmPasswordValid) validateConfirmPassword();

          if (identical(phoneController.value.text,confirmPasswordController.value.text))
            setState(() {
              isConfirmPasswordValid = true;
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
                          alignment: Alignment.center,
                          child: AppText(
                            text: "Create your account",
                            style: AppTextStyle.title,
                            color: ColorConstants.mainColor,
                            align: true,
                          ),
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),

                        AppTextField(
                          hintText: "Name",
                          inputType: TextInputType.name,
                          action: TextInputAction.next,
                          controller: nameController,
                          node: nodes[0],
                          password: false,
                          nextNode: nodes[1],
                          valid: isNameValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(4),
                        ),
                        AppTextField(
                          hintText: "  Phone",
                          inputType: TextInputType.phone,
                          action: TextInputAction.next,
                          controller: phoneController,
                          widget: SizedBox(
                              width: scaler.getWidth(18),
                              height: 1,
                              child: country(context)),
                          node: nodes[1],
                          password: false,
                          nextNode: nodes[2],
                          valid: isPhoneValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(4),
                        ),
                        AppTextField(
                          node: nodes[2],
                          nextNode: nodes[3],
                          hintText: "Email",
                          inputType: TextInputType.emailAddress,
                          action: TextInputAction.next,
                          controller: emailController,
                          password: false,
                          valid: isEmailValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(5),
                        ),
                        AppTextField(
                          node: nodes[3],
                          nextNode: nodes[4],
                          hintText: "Password",
                          action: TextInputAction.next,
                          controller: passwordController,
                          password: true,
                          valid: isPasswordValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(4),
                        ),
                        AppTextField(
                          node: nodes[4],
                          hintText: "Confirm password",
                          action: TextInputAction.done,
                          controller: confirmPasswordController,
                          password: true,
                          valid: isConfirmPasswordValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(4),
                        ),
                        RadioButtonSignUp(gander: gander,),
                        SizedBox(
                          height: scaler.getHeight(4),
                        ),
                        GestureDetector(
                          onTap: () {

                            Navigator.of(context)
                                .popAndPushNamed(RoutesConstants.signIn);


                          },
                          child: Container(
                              padding: scaler.getPadding(1, 1),
                              alignment: Alignment.topRight,
                              child: AppText(
                                text: "Existing",
                                color: ColorConstants.mainColor,
                              )),
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: AppButton(enabled: (isEmailValid != null && isEmailValid) &&
                              (isPasswordValid != null && isPasswordValid) &&
                              (isNameValid != null && isNameValid)&& (isPhoneValid != null && isPhoneValid)
                              && (isConfirmPasswordValid != null && isConfirmPasswordValid) ,
                          text: "Sign up",
                            width: 100,
                            textEnabledColor: ColorConstants.grey,
                            borderColor: ColorConstants.mainColor,
                            mainColor: ColorConstants.mainColor,
                            onPressed: ()async{

                              SharedPreferences nameSahred =
                                  await SharedPreferences.getInstance();
                              nameSahred.setString(Common.name, nameController.text.toString());


                              SharedPreferences pass =
                                  await SharedPreferences.getInstance();
                              pass.setString(Common.password, passwordController.text.toString());

                                setState(() {

                                  animation = true;
                                  RegisterModel body = RegisterModel();

                                  provider.registerUser(body, nameController.text.toString(), emailController.text.toString(), passwordController.text.toString(), context);
                                 animation = false;


                                });

                                                        },
                          )
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),
                        AppText(
                          text: errorText,
                          color: ColorConstants.red,
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),
                                          ],
                    ),
                  ),
                )
            ),
          animation != false?  Positioned(
              child: Container(
                  color: ColorConstants.grey.withOpacity(.5),
                  child: Center(child: Lottie.asset('animations/loader.json'))),
            ): Container(),
          ],
        )
      ),
    );
  }







  validateName() {
    setState(() {
      isNameValid = Validations.nameValidation(nameController.text.toString());
    });
  }
  validatePhone() {
    setState(() {
      isPhoneValid = Validations.phoneValidation(phoneController.text.toString());
      errorText=!isPhoneValid ? "Invalid phone number":"";

    });
  }
  validateEmail() {
    setState(() {
      isEmailValid =
          Validations.emailValidation(emailController.text.toString());

      errorText=!isEmailValid ? "Invalid email":"";
    });
  }
  validatePassword() {
    setState(() {
      isPasswordValid =Validations.passwordValidation(passwordController.text.toString());
      errorText=!isPasswordValid ? "Invalid password":"";
    });
  }
  validateConfirmPassword() {
    setState(() {
      isConfirmPasswordValid =Validations.passwordConfirmValidation(confirmPasswordController.value.text , passwordController.value.text);
      errorText=!isConfirmPasswordValid ? " password dose'nt match":"";

    });
  }




}


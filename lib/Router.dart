

import 'package:flutter/material.dart';
import 'file:///E:/FlutterProjects/weatherapptask/lib/View/initalScreens/Splash.dart';

import 'Constant/RoutesConstants.dart';
import 'Navigation/Navigation.dart';
import 'View/HomePage.dart';
import 'View/initalScreens/SignIn.dart';
import 'View/initalScreens/sign_up.dart';


class PageRouter{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstants.splash:
        return PageNavigation(child: Splash(), settings: settings);
      case RoutesConstants.signIn:
        return PageNavigation(
            child: SignIn(), settings: settings);

      case RoutesConstants.signUp:
        return PageNavigation(
            child:SignUp(), settings: settings);

      case RoutesConstants.homePage:
        return PageNavigation(
            child:HomePage(), settings: settings);

    }

    }
}
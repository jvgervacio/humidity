import 'package:flutter/material.dart';
import 'package:humidity/views/dashboard/dashboard_view.dart';
import 'package:humidity/views/login/login_view.dart';
import 'package:humidity/views/signup/signup_view.dart';
import 'package:humidity/views/splash/splash_view.dart';

const String dashboard = "dashboard";
const String loginPage = "login";
const String signupPage = "signup";
const String splash = "splash";

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboard:
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    case splash:
      return MaterialPageRoute(builder: (context) => const Splash(), maintainState: false, fullscreenDialog: true);
    default:
      throw ("This route name does not exist");
  }
}

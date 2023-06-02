import 'package:flutter/material.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/initial_page.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/login_page.dart';
import 'package:igrejoteca_app/modules/login/UI/pages/signup_page.dart';


class LoginRoutes {
  static const String login = LoginPage.route;
  static const String initalLogin = InitialPage.route;
  static const String signup = SignupPage.route;

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    initalLogin:(context) => const InitialPage(),
    signup:(context) => const SignupPage()
  };
}
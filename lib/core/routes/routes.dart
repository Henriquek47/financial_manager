import 'package:financial_manager/features/auth/view/sign_in_view.dart';
import 'package:financial_manager/features/auth/view/sign_up_view.dart';
import 'package:financial_manager/features/home/view/manager_widget.dart';
import 'package:financial_manager/features/payment/view/payment_view.dart';
import 'package:financial_manager/features/payment/view/receive_view.dart';
import 'package:financial_manager/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRouters {
  static const splash = '/splash';
  static const home = '/home';
  static const payment = '/payment';
  static const receipt = '/receipt ';
  static const signUp = '/sign_up';
  static const signIn = '/sign_uin';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRouters.splash:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) =>
            const SplashView(), //MainView(currentIndex: index),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    case AppRouters.signUp:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => const SignUpView(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    case AppRouters.signIn:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => const SignInView(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    case AppRouters.home:
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => const ManagerWidget(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    case AppRouters.payment:
      final args = settings.arguments as String;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => PaymentView(
          userId: args,
        ),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    case AppRouters.receipt:
      final args = settings.arguments as String;
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => ReceiveView(
          userId: args,
        ),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      );
    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}

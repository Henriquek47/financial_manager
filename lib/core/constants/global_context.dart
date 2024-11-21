import 'package:flutter/material.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalContext? _instance;

  GlobalContext._();

  // ignore: prefer_constructors_over_static_methods
  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }
}

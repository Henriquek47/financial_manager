import 'package:financial_manager/core/constants/global_context.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveExtension on num {
  double get appFont {
    final context = GlobalContext.instance.navigatorKey.currentContext!;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final isTablet = shortestSide >= 600;
    if (isTablet) {
      return r;
    } else if (kIsWeb) {
      return toDouble();
    } else {
      return sp;
    }
  }

  double get appIcon {
    final context = GlobalContext.instance.navigatorKey.currentContext!;
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final isTablet = shortestSide >= 600;
    if (isTablet) {
      return r + 4;
    } else if (kIsWeb) {
      return toDouble();
    } else {
      return sp;
    }
  }

  double get appHeight {
    if (kIsWeb) {
      return toDouble();
    } else {
      return h;
    }
  }

  double get appWidth {
    if (kIsWeb) {
      return toDouble();
    } else {
      return w;
    }
  }

  double get appAdaptive {
    if (kIsWeb) {
      return toDouble();
    } else {
      return r;
    }
  }

  double get appPadding {
    if (kIsWeb) {
      return toDouble();
    } else {
      return r;
    }
  }
}
  
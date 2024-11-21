import 'package:financial_manager/core/constants/global_context.dart';
import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  // ignore: prefer_constructors_over_static_methods
  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  static const String montserratAlternates = 'MontserratAlternates';

  String get fontMontserratAlternates => 'MontserratAlternates';

  // Método para retornar a cor conforme o modo (claro ou escuro)
  Color _getTextColor(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).themeData;
    if (theme.brightness == Brightness.dark) {
      return ColorsApp.instance.neutralShade100;
    } else {
      return context.colors.neutralShade550;
    }
  }

  Color _getTextColorGrey(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).themeData;
    if (theme.brightness == Brightness.dark) {
      return ColorsApp.instance.neutralShade200;
    } else {
      return ColorsApp.instance.neutralShade400;
    }
  }

  TextStyle get headingTitleBold => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: fontMontserratAlternates,
        fontSize: 21.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get headingTitleSemiBold => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: fontMontserratAlternates,
        fontSize: 21.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get headingAppBarScreen => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: fontMontserratAlternates,
        fontSize: 17.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get titleBodyBold => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: fontMontserratAlternates,
        fontSize: 19.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get secondaryText => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get bodyTextLight => TextStyle(
        fontWeight: FontWeight.w300,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get bodyText => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );
  TextStyle get bodyTextDescription => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color: _getTextColorGrey(
            GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get bodyTextMedium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get bodyTextBold => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );
      
  TextStyle get bodyTextSemiBold => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get buttonText => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: fontMontserratAlternates,
        fontSize: 15.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get caption => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontMontserratAlternates,
        fontSize: 12.appFont,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get infoText => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontMontserratAlternates,
        fontSize: 13.appFont,
        height: 1.3,
        color:
            _getTextColor(GlobalContext.instance.navigatorKey.currentContext!),
      );

  TextStyle get link => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontMontserratAlternates,
        fontSize: 12.appFont,
        decoration: TextDecoration.underline,
        color: ColorsApp.instance.primary,
      );
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}

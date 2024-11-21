import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool _password;
  final TextEditingController controller;
  final FocusNode? nextFocus;
  final String labelText;
  final Widget? suffixIcon;
  final FocusNode? myFocus;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? mask;
  final TextInputType? keyboardType;
  final int? maxLength;
  final ValueNotifier<bool> obscureText;
  final VoidCallback? validation;

  CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.nextFocus,
    this.suffixIcon,
    this.myFocus,
    this.mask,
    this.keyboardType,
    this.maxLength,
    this.validation,
  })  : _password = false,
        obscureText = ValueNotifier(false);

  CustomTextField.password({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.nextFocus,
    this.suffixIcon,
    this.myFocus,
    this.mask,
    this.keyboardType,
    this.maxLength,
    this.validation,
  })  : _password = true,
        obscureText = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.appAdaptive,
        color: isDarkMode
            ? context.colors.neutralShade300
            : context.colors.neutralShade500,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.appAdaptive)),
    );
    return ValueListenableBuilder(
      valueListenable: obscureText,
      builder: (context, isObscure, child) {
        return TextFormField(
          focusNode: myFocus,
          validator: validator,
          obscureText: isObscure,
          keyboardType: keyboardType ??
              (!_password ? TextInputType.emailAddress : TextInputType.text),
          controller: controller,
          style: context.textStyles.bodyText.copyWith(color: isDarkMode ? context.colors.neutralShade300 : context.colors.neutralShade500),
          maxLength: maxLength,
          inputFormatters: mask,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(nextFocus);
          },
          onChanged: (value) {
            validation?.call();
          },
          decoration: InputDecoration(
            errorStyle: TextStyle(
              color: context.colors.errorColor,
              fontSize: 11.appFont,
            ),
            isDense: true,
            fillColor: context.colors.secondary.withOpacity(0.08),
            filled: true,
            labelText: labelText,
            labelStyle: context.textStyles.bodyText.copyWith(
                fontSize: 13.appFont,
                color: isDarkMode
                    ? context.colors.neutralShade300
                    : context.colors.neutralShade500),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.appPadding,
              vertical: 14.appPadding,
            ),
            suffixIcon: _password
                ? InkWell(
                    onTap: () {
                      obscureText.value = !obscureText.value;
                    },
                    child: Icon(
                      isObscure
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_sharp,
                      size: 20.appIcon,
                      color: context.colors.neutralShade400,
                    ),
                  )
                : suffixIcon,
            suffixIconConstraints: BoxConstraints(minWidth: 36.appPadding),
            counterText: '',
            enabledBorder: defaultBorder,
            border: defaultBorder,
            focusedBorder: null,
          ),
        );
      },
    );
  }
}

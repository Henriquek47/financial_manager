import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool isEnabled;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
   const CustomButtonWidget(
      {super.key,
      required this.height,
      required this.width,
      this.isEnabled = true,
      required this.onPressed,
      required this.backgroundColor,
       required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            isEnabled ? backgroundColor : context.colors.neutralShade300,
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.zero
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.appAdaptive),
            ),
          ),
        ),
        child: Text(
          label,
          style: context.textStyles.bodyText.copyWith(
            color: isEnabled
                ? context.colors.neutralWhite
                : context.colors.neutralShade100,
            fontSize: 14.appFont,
            height: 1,
          ),
        ),
      ),
    );
  }
}

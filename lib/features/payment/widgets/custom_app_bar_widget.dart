import 'package:financial_manager/core/constants/assets.dart';
import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/icon_svg_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String label;
  const CustomAppBarWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
            horizontal: 12.appWidth, vertical: 16.appHeight),
        padding: EdgeInsets.symmetric(
            vertical: 16.appHeight, horizontal: 16.appWidth),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.appAdaptive),
            color: context.colors.neutralShade600),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: IconSvgWidget(
                  asset: Assets.arrowLeft,
                  color: context.colors.primary,
                  size: 28.appIcon,
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: context.textStyles.headingTitleSemiBold
                    .copyWith(fontSize: 16.appFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

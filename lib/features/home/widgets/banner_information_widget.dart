import 'package:financial_manager/core/constants/assets.dart';
import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/icon_svg_widget.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class BannerInformationWidget extends StatelessWidget {
  const BannerInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding:
          EdgeInsets.symmetric(vertical: 10.appWidth, horizontal: 8.appWidth),
      decoration: BoxDecoration(
        color: context.isDarkMode ? context.colors.primaryDark.withOpacity(0.4) : context.colors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.appAdaptive),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.colors.neutralShade200,
            radius: 18.appAdaptive,
          ),
          SizedBox(
            width: 8.appWidth,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                style:
                    context.textStyles.bodyText.copyWith(fontSize: 12.appFont),
                children: [
                  const TextSpan(
                    text: 'Confira os valores de seus ',
                  ),
                  TextSpan(
                    text: 'ganhos',
                    style: context.textStyles.bodyTextBold.copyWith(
                      fontSize: 13.appFont,
                    ),
                  ),
                  const TextSpan(
                    text: ' e suas ',
                  ),
                  TextSpan(
                    text: 'despesas',
                    style: context.textStyles.bodyTextBold.copyWith(
                      fontSize: 13.appFont,
                    ),
                  ),
                  const TextSpan(
                    text: ' do mês de novembro',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 4.appWidth,
          ),
          IconSvgWidget(
              asset: Assets.arrowRight,
              color: context.isDarkMode ?  context.colors.neutralWhite : context.colors.neutralShade500,
              size: 20.appIcon,),
          SizedBox(
            width: 4.appWidth,
          )
        ],
      ),
    );
  }
}

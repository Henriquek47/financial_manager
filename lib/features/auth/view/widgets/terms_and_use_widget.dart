import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:flutter/material.dart';

class TermsAndUseWidget extends StatelessWidget {
  const TermsAndUseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.textStyles.bodyText.copyWith(fontSize: 12.appFont),
        children: [
            TextSpan(text: 'Ao prosseguir, você concorda com os nossos ', style:   context.textStyles.bodyText.copyWith(fontSize: 12.appFont,),),
          TextSpan(
            text: 'Termos de Uso',
            style: context.textStyles.bodyTextBold
                .copyWith(color: context.colors.primary, fontSize: 12.appFont),
          ),
          const TextSpan(text: ' e '),
          TextSpan(
            text: 'Política de Privacidade',
            style: context.textStyles.bodyTextBold
                .copyWith(color: context.colors.primary, fontSize: 12.appFont),
          ),
        ],
      ),
    );
  }
}

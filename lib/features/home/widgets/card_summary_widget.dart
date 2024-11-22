import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/custom_button_widget.dart';
import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardSummaryWidget extends StatefulWidget {
  final UserModel? user;
  const CardSummaryWidget({super.key, required this.user});

  @override
  State<CardSummaryWidget> createState() => _CardSummaryWidgetState();
}

class _CardSummaryWidgetState extends State<CardSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 16.appWidth, vertical: 12.appHeight),
      decoration: BoxDecoration(
          color: context.isDarkMode
              ? context.colors.neutralShade600
              : context.colors.neutralWhite,
          borderRadius: BorderRadius.circular(8.appAdaptive)),
      child: Column(
        children: [
          SizedBox(
            height: 6.appHeight,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, ${widget.user?.name ?? ''}',
                    style: context.textStyles.bodyTextBold.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1,
                        fontSize: 14.appFont),
                  ),
                  Text(
                    'Bem vindo ao Couze',
                    style: context.textStyles.bodyText.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 11.appFont,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 2.appHeight, horizontal: 10.appWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.isDarkMode
                      ? context.colors.secondary
                      : context.colors.primary.withOpacity(0.3),
                ),
                child: Text(
                  DateFormat('dd/MM').format(DateTime.now()),
                  style: context.textStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.appFont,
                    color: context.isDarkMode
                        ? context.colors.neutralWhite
                        : context.colors.neutralShade600,
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: context.colors.neutralShade200,
            height: 20.appHeight,
          ),
          Text(
            'Saldo Total',
            style: context.textStyles.bodyText.copyWith(
              color: context.isDarkMode
                  ? context.colors.neutralShade300
                  : context.colors.neutralShade500,
              fontSize: 14.appFont,
            ),
          ),
          Text(
            'R\$ ${(widget.user?.wallet!.value ?? 0).toStringAsFixed(2)}',
            style: context.textStyles.bodyTextBold
                .copyWith(fontSize: 20.appFont, height: 1),
          ),
          Text(
            'Total gasto: R\$ ${(widget.user?.expenses ?? 0).toStringAsFixed(2)}',
            style: context.textStyles.bodyText.copyWith(
              color: context.isDarkMode
                  ? context.colors.neutralShade300
                  : context.colors.neutralShade500,
              fontSize: 12.appFont,
            ),
          ),
          SizedBox(
            height: 16.appHeight,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
                  height: 35.appHeight,
                  width: 100,
                  label: 'Pagar',
                  onPressed: ()  => Navigator.pushNamed(context, AppRouters.payment, arguments: widget.user!.id),
                  backgroundColor: context.colors.primary,
                ),
              ),
              SizedBox(
                width: 8.appWidth,
              ),
              Expanded(
                child: CustomButtonWidget(
                  height: 35.appHeight,
                  width: 100,
                  label: 'Receber',
                  onPressed: () => Navigator.pushNamed(context, AppRouters.receipt, arguments: widget.user!.id),
                  backgroundColor: context.colors.secondary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

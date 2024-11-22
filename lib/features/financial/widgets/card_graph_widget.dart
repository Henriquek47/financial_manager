import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/dropdown_filter_widget.dart';
import 'package:financial_manager/features/financial/view_model/financial_view_model.dart';
import 'package:financial_manager/features/financial/widgets/graph_widget.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class CardGraphWidget extends StatelessWidget {
  final FinancialViewModel financialViewModel;
  const CardGraphWidget({super.key, required this.financialViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: context.isDarkMode
          ? context.colors.neutralShade600
          : context.colors.neutralWhite,
      padding: EdgeInsets.only(
          top: 16.appHeight, left: 16.appWidth, right: 16.appWidth),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gasto total',
                    style: context.textStyles.bodyText
                        .copyWith(height: 1, fontSize: 12.appFont),
                  ),
                  Text(
                    'R\$ ${(financialViewModel.graphModel?.total ?? 0).toStringAsFixed(2)}',
                    style: context.textStyles.bodyTextSemiBold.copyWith(
                      fontSize: 18.appFont,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              DropdownFilterWidget(
                onTap: (value){
                  financialViewModel.selectFilterGraph = SelectFilterGraph.values[value];
                  financialViewModel.getFinancialGraph(financialViewModel.selectFilterGraph);
                },
              )
            ],
          ),
          GraphWidget(
            breakdown: financialViewModel.graphModel?.breakdown ?? [],
          ),
        ],
      ),
    );
  }
}

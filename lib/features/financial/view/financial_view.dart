import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/categories_expansives_widget.dart';
import 'package:financial_manager/core/widgets/summary_widget.dart';
import 'package:financial_manager/features/financial/view_model/financial_view_model.dart';
import 'package:financial_manager/features/financial/widgets/card_graph_widget.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialView extends StatefulWidget {
  const FinancialView({super.key});

  @override
  State<FinancialView> createState() => _FinancialViewState();
}

class _FinancialViewState extends State<FinancialView> {
  late FinancialViewModel financialViewModel;

  @override
  void initState() {
    financialViewModel = context.read<FinancialViewModel>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await financialViewModel.getUser();
        await financialViewModel.getSummaryData(DateTime.now().month);
        await financialViewModel.getFinancialGraph(financialViewModel.selectFilterGraph);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    financialViewModel = context.watch<FinancialViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.isDarkMode
            ? context.colors.neutralShade600
            : context.colors.neutralWhite,
        title: Text('Estatistica Financeira',
            style: context.textStyles.bodyTextSemiBold),
        centerTitle: true,
        leading: const SizedBox.shrink(),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0, -1.5),
                end: Alignment.center,
                colors: context.isDarkMode
                    ? [
                        context.colors.primaryDark.withOpacity(0.5),
                        context.colors.neutralShade600
                      ]
                    : [
                        context.colors.primary.withOpacity(0.7),
                        context.colors.neutralWhite
                      ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(vertical: 12.appHeight),
                  padding: EdgeInsets.symmetric(
                      vertical: 16.appHeight, horizontal: 16.appWidth),
                  color: context.isDarkMode
                      ? context.colors.neutralShade600
                      : context.colors.neutralWhite,
                  child: SummaryWidget(
                    total: financialViewModel.summary?.total ?? 0,
                    showTitle: false,
                    categories: financialViewModel.summary?.categories ?? [],
                    onTap: (month) async{
                      await financialViewModel.getSummaryData(month);
                    },
                  ),
                ),
                  CardGraphWidget(financialViewModel: financialViewModel,),
                Container(
                    width: double.maxFinite,
                    color: context.isDarkMode
                        ? context.colors.neutralShade600
                        : context.colors.neutralWhite,
                    padding: EdgeInsets.only(
                        top: 16.appHeight,
                        left: 16.appWidth,
                        right: 16.appWidth),
                    child: const CategoriesExpansivesWidget())
              ],
            ),
          )
        ],
      ),
    );
  }
}

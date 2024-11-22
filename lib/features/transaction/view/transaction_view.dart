import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/custom_button_widget.dart';
import 'package:financial_manager/core/widgets/transaction_list_widget.dart';
import 'package:financial_manager/features/transaction/view_model/transaction_view_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  late TransactionViewModel transactionViewModel;

  @override
  void initState() {
    transactionViewModel = context.read<TransactionViewModel>();
    Future.microtask(
      () async {
        await transactionViewModel.getUser();
        await transactionViewModel.getTransactions();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    transactionViewModel = context.watch<TransactionViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.isDarkMode
            ? context.colors.neutralShade600
            : context.colors.neutralWhite,
        title: Text('Transações', style: context.textStyles.bodyTextSemiBold),
        centerTitle: true,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: context.isDarkMode
                      ? context.colors.neutralShade600
                      : context.colors.neutralWhite,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.appHeight, horizontal: 16.appWidth),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ValueListenableBuilder(
                        valueListenable: transactionViewModel.selectedValue,
                        builder: (context, value, _) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ordernar por:',
                                  style: context.textStyles.bodyText
                                      .copyWith(fontSize: 16.appFont)),
                              SizedBox(
                                height: 16.appHeight,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 0,
                                      groupValue: value,
                                      onChanged: (value) {
                                        transactionViewModel
                                            .selectedValue.value = value ?? 0;
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  Text(
                                    'Todos',
                                    style: context.textStyles.bodyText
                                        .copyWith(fontSize: 14.appFont),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: value,
                                      onChanged: (value) {
                                        transactionViewModel
                                            .selectedValue.value = value ?? 0;
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  Text(
                                    'Valor',
                                    style: context.textStyles.bodyText
                                        .copyWith(fontSize: 14.appFont),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 2,
                                      groupValue: value,
                                      onChanged: (value) {
                                        transactionViewModel
                                            .selectedValue.value = value ?? 0;
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  Text(
                                    'Data',
                                    style: context.textStyles.bodyText
                                        .copyWith(fontSize: 14.appFont),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.appHeight,),
                              CustomButtonWidget(
                                height: 50.appHeight,
                                width: double.maxFinite,
                                onPressed: () async {
                                  final navigator = Navigator.of(context);
                                  if (value == 0) {
                                    transactionViewModel.sortByDate = null;
                                    transactionViewModel.sortByValue = null;
                                  } else if (value == 1) {
                                    transactionViewModel.sortByValue = 'asc';
                                  } else {
                                    transactionViewModel.sortByDate = 'asc';
                                  }
                                  transactionViewModel.transactions.clear();
                                  await transactionViewModel.getTransactions();
                                  navigator.pop();
                                },
                                backgroundColor: context.colors.primary,
                                label: 'Ordenar',
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.filter_alt_outlined,
              color: context.isDarkMode
                  ? context.colors.neutralWhite
                  : context.colors.neutralShade500,
            ),
          )
        ],
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
          Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: 12.appHeight),
              padding: EdgeInsets.symmetric(
                  vertical: 16.appHeight, horizontal: 16.appWidth),
              color: context.isDarkMode
                  ? context.colors.neutralShade600
                  : context.colors.neutralWhite,
              child: TransactionListWidget(
                transactions: transactionViewModel.transactions,
                showTitle: false,
              )),
        ],
      ),
    );
  }
}

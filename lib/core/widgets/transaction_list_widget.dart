import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/models/response/transaction_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListWidget extends StatelessWidget {
  final bool showTitle;
  final List<TransactionModel> transactions;
  const TransactionListWidget({super.key, required this.transactions,   this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(showTitle)...[Text(
          'Transações',
          style: context.textStyles.bodyTextSemiBold,
        ),
        SizedBox(
          height: 8.appHeight,
        ),],
        transactions.isEmpty ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 54.appHeight),
                  child: Text(
                    'Nenhuma transação efetuada',
                    textAlign: TextAlign.center,
                    style: context.textStyles.bodyTextSemiBold.copyWith(
                      fontSize: 12.appFont,
                    ),
                  ),
                ),
              ) : Padding(
          padding: EdgeInsets.only(left: showTitle ? 16.appWidth : 0),
          child: ListView.builder(
            itemCount: transactions.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: context.isDarkMode
                            ? context.colors.neutralShade550
                            : context.colors.neutralShade400,
                        radius: 20.appAdaptive,
                      ),
                      SizedBox(
                        width: 12.appWidth,
                      ),
                      Expanded(
                        flex: 3,
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions[index].category?.name ?? 'Recebimento',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  context.textStyles.bodyTextSemiBold.copyWith(
                                fontSize: 14.appFont,
                                color: context.isDarkMode
                                    ? context.colors.neutralWhite
                                    : context.colors.neutralShade500,
                              ),
                            ),
                            Text(
                              transactions[index].description ??
                                  'Sem descrição',
                              overflow: TextOverflow.ellipsis,
                              style: context.textStyles.bodyText.copyWith(
                                fontSize: 11.appFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'R\$ ${transactions[index].value.toStringAsFixed(2)}',
                            style: context.textStyles.bodyTextSemiBold.copyWith(
                                fontSize: 14.appFont,
                                color: transactions[index].category?.name == null ? Colors.green : context.isDarkMode
                                    ? context.colors.neutralWhite
                                    : context.colors.neutralShade500),
                          ),
                          Text(
                            DateFormat('d MMMM yyyy')
                                .format(transactions[index].createdAt),
                            overflow: TextOverflow.ellipsis,
                            style: context.textStyles.bodyText
                                .copyWith(fontSize: 11.appFont),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: context.isDarkMode
                        ? context.colors.neutralShade550
                        : context.colors.neutralShade200,
                    height: 24.appHeight,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

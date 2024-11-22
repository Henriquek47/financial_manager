import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/category_total_spent_widget.dart';
import 'package:financial_manager/core/widgets/dropdown_month_widget.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatefulWidget {
  final bool showTitle;
  final double total;
  final List<CategoryModel> categories;
  final Function(int month) onTap;
  const SummaryWidget(
      {super.key,
      required this.showTitle,
      required this.categories,
      required this.total,
      required this.onTap});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  ExpansionTileController? controller;
  bool _isExpanded = false;

  @override
  void initState() {
    controller = ExpansionTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTitle) ...[
          Text(
            'Resumo',
            style: context.textStyles.bodyTextSemiBold,
          ),
          SizedBox(
            height: 8.appHeight,
          ),
        ],
        widget.categories.isEmpty
            ? Center(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: DropdownMonthWidget(
                            selected: 0,
                            onTap: (month) => widget.onTap.call(month),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.appHeight),
                      child: Text(
                        'Nada por aqui',
                        textAlign: TextAlign.center,
                        style: context.textStyles.bodyTextSemiBold.copyWith(
                          fontSize: 12.appFont,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding:
                    EdgeInsets.only(left: widget.showTitle ? 12.appWidth : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lucro do mês',
                              style: context.textStyles.bodyText
                                  .copyWith(height: 1, fontSize: 12.appFont),
                            ),
                            Text(
                              'R\$ ${widget.total.toStringAsFixed(2)}',
                              style:
                                  context.textStyles.bodyTextSemiBold.copyWith(
                                fontSize: 18.appFont,
                                color: widget.total >= 0
                                    ? Colors.green
                                    : const Color.fromARGB(
                                        255,
                                        192,
                                        44,
                                        33,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        DropdownMonthWidget(
                          selected: 0,
                          onTap: (month) => widget.onTap.call(month),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.appHeight,
                    ),
                    Row(
                      children: widget.categories
                          .map(
                            (e) => Expanded(
                              flex: e.totalSpent!.toInt().abs(),
                              child: Container(
                                height: 20.appHeight,
                                decoration: BoxDecoration(
                                  color: e.getColor().withOpacity(0.8),
                                  borderRadius:
                                      BorderRadius.circular(4.appAdaptive),
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 2.appWidth,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 8.appHeight,
                    ),
                    ListView.builder(
                      itemCount: widget.categories.length > 3
                          ? 3
                          : widget.categories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.appHeight),
                          child: CategoryTotalSpentWidget(
                              category: widget.categories[index]),
                        );
                      },
                    ),
                    if (widget.categories.length > 3) ...[
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.only(bottom: 8.appHeight),
                        minTileHeight: 0,
                        showTrailingIcon: false,
                        controller: controller,
                        title: CategoryTotalSpentWidget(
                            category: widget.categories[3]),
                        children: widget.categories
                            .skip(4)
                            .map(
                              (e) => CategoryTotalSpentWidget(
                                category: e,
                              ),
                            )
                            .toList(),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller!.isExpanded) {
                            controller!.collapse();
                            _isExpanded = false;
                          } else {
                            controller!.expand();
                            _isExpanded = true;
                          }
                          setState(() {});
                        },
                        child: widget.categories.length > 4
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Ver mais',
                                    style: context.textStyles.bodyText.copyWith(
                                      fontSize: 14.appAdaptive,
                                    ),
                                  ),
                                  Icon(
                                    _isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: context.isDarkMode
                                        ? context.colors.neutralWhite
                                        : context.colors.neutralShade500,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ]
                  ],
                ),
              ),
      ],
    );
  }
}

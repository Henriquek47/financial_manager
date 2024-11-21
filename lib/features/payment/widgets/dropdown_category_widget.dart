import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/features/payment/view_model/payment_view_model.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:flutter/material.dart';

class DropdownCategoryWidget extends StatefulWidget {
  final PaymentViewModel paymentViewModel;
  final List<CategoryModel> categories;
  const DropdownCategoryWidget(
      {super.key, required this.categories, required this.paymentViewModel});

  @override
  State<DropdownCategoryWidget> createState() => _DropdownCategoryWidgetState();
}

class _DropdownCategoryWidgetState extends State<DropdownCategoryWidget> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6.appAdaptive),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        underline: const SizedBox.shrink(),
        padding: EdgeInsets.symmetric(vertical: 2.appHeight),
        isDense: true,
        value: _selectedIndex!,
        items: widget.categories
            .asMap()
            .map(
              (index, e) => MapEntry(
                index,
                DropdownMenuItem<int>(
                  value: index,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.appWidth),
                    child: Text(
                      e.name,
                      style: context.textStyles.bodyText
                          .copyWith(fontSize: 12.appFont, height: 1),
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList(),
        onChanged: (index) {
          setState(() {
            _selectedIndex = index;
            widget.paymentViewModel.category = widget.categories[_selectedIndex ?? 0].id;
          });
        },
      ),
    );
  }
}

import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class CategoryTotalSpentWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryTotalSpentWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: category.getColor().withOpacity(0.8),
          radius: 6.appAdaptive,
        ),
        SizedBox(
          width: 6.appWidth,
        ),
        Text(
          category.name,
          style: context.textStyles.bodyText.copyWith(fontSize: 10.appFont),
        ),
        const Spacer(),
        category.totalSpent != null
            ? Text(
                'R\$ ${category.totalSpent}',
                style: context.textStyles.bodyTextSemiBold.copyWith(
                    fontSize: 11.appFont,
                    color: category.receipt()
                        ? Colors.green
                        : context.isDarkMode
                            ? context.colors.neutralWhite
                            : context.colors.neutralShade500),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

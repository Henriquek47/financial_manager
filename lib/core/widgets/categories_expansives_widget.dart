import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class CategoriesExpansivesWidget extends StatefulWidget {
   const CategoriesExpansivesWidget({super.key });

  @override
  State<CategoriesExpansivesWidget> createState() => _CategoriesExpansivesWidgetState();
}

class _CategoriesExpansivesWidgetState extends State<CategoriesExpansivesWidget> {
  
  List<CategoryModel> categories = [
    CategoryModel(
      id: 'cat_1',
      name: 'Technology',
      image: 'https://example.com/tech.jpg',
      isPublic: true,
      totalSpent: 500.00,
      color: '#FF5733',
      profit: 12.0
    ),
    CategoryModel(
      id: 'cat_2',
      name: 'Health',
      image: 'https://example.com/health.jpg',
      isPublic: false,
      totalSpent: 150.75,
      color: '#33FF57',
      profit: 12.0
    ),
    CategoryModel(
      id: 'cat_3',
      name: 'Education',
      image: 'https://example.com/education.jpg',
      isPublic: true,
      totalSpent: 320.40,
      color: '#3357FF',
      profit: 12.0
    ),
    CategoryModel(
      id: 'cat_4',
      name: 'Sports',
      image: 'https://example.com/sports.jpg',
      isPublic: true,
      totalSpent: 250.60,
      color: '#57FF33',
      profit: 12.0
    ),
    CategoryModel(
      id: 'cat_5',
      name: 'Entertainment',
      image: 'https://example.com/entertainment.jpg',
      isPublic: false,
      totalSpent: 100.20,
      color: '#FF33A6',
      profit: 12.0
    ),
  ];

  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           Text(
            'Maiores gastos',
            style: context.textStyles.bodyText.copyWith(
              height: 1,
              color: context.isDarkMode ? context.colors.neutralShade200 : context.colors.neutralShade500, fontSize: 11.appFont),
          ),
          Text(
            'Categorias',
            style: context.textStyles.bodyTextSemiBold.copyWith(height: 1),
          ),
          SizedBox(
            height: 16.appHeight,
          ),
         Padding(
          padding: EdgeInsets.only(left: 16.appWidth),
          child: ListView.builder(
            itemCount: categories.length,
            shrinkWrap: true,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categories[index].name,
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
                              'Aumento de:',
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
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            categories[index].totalSpent!.toStringAsFixed(2),
                            style: context.textStyles.bodyTextSemiBold.copyWith(
                                fontSize: 14.appFont,
                                color: context.isDarkMode
                                    ? context.colors.neutralWhite
                                    : context.colors.neutralShade500),
                          ),
                          Text(
                            '${categories[index].profit}%',
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

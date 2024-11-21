import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/transaction_list_widget.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:financial_manager/models/response/transaction_model.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  List<TransactionModel> transactionModels = [
    TransactionModel(
      id: '1',
      value: 100.50,
      description: 'Compra no supermercado',
      userId: 'user_01',
      category: CategoryModel(
        id: 'cat_5',
        name: 'Entertainment',
        image: 'https://example.com/entertainment.jpg',
        isPublic: false,
        totalSpent: 100.20,
        color: '#FF33A6',
      ),
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      receiverId: 'receiver_01',
    ),
    TransactionModel(
      id: '2',
      value: 200.75,
      description: 'Pagamento de aluguel',
      userId: 'user_02',
      category: CategoryModel(
        id: 'cat_5',
        name: 'Entertainment',
        image: 'https://example.com/entertainment.jpg',
        isPublic: false,
        totalSpent: 100.20,
        color: '#FF33A6',
      ),
      createdAt: DateTime.now().subtract(Duration(days: 4)),
      receiverId: 'receiver_02',
    ),
    TransactionModel(
      id: '3',
      value: 50.25,
      description: 'Compra de gasolina',
      userId: 'user_03',
      category: CategoryModel(
        id: 'cat_5',
        name: 'Entertainment',
        image: 'https://example.com/entertainment.jpg',
        isPublic: false,
        totalSpent: 100.20,
        color: '#FF33A6',
      ),
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      receiverId: 'receiver_03',
    ),
    TransactionModel(
      id: '4',
      value: 1500.00,
      description: 'Pagamento de salário',
      userId: 'user_04',
      category: CategoryModel(
        id: 'cat_5',
        name: 'Entertainment',
        image: 'https://example.com/entertainment.jpg',
        isPublic: false,
        totalSpent: 100.20,
        color: '#FF33A6',
      ),
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      receiverId: 'receiver_04',
    ),
    TransactionModel(
      id: '5',
      value: 75.00,
      description: 'Jantar com amigos',
      userId: 'user_05',
      category: CategoryModel(
        id: 'cat_5',
        name: 'Entertainment',
        image: 'https://example.com/entertainment.jpg',
        isPublic: false,
        totalSpent: 100.20,
        color: '#FF33A6',
      ),
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      receiverId: 'receiver_05',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: context.isDarkMode ? context.colors.neutralShade600 :context.colors.neutralWhite,

        title: Text('Transações', style: context.textStyles.bodyTextSemiBold),
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
          Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: 12.appHeight),
              padding: EdgeInsets.symmetric(
                  vertical: 16.appHeight, horizontal: 16.appWidth),
              color: context.isDarkMode ? context.colors.neutralShade600 : context.colors.neutralWhite,
              child: TransactionListWidget(transactions: transactionModels, showTitle: false,)),
        ],
      ),
    );
  }
}

import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/widgets/summary_widget.dart';
import 'package:financial_manager/core/widgets/transaction_list_widget.dart';
import 'package:financial_manager/features/home/view_model/home_view_model.dart';
import 'package:financial_manager/features/home/widgets/banner_information_widget.dart';
import 'package:financial_manager/features/home/widgets/card_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = context.read<HomeViewModel>();
    Future.microtask(
      () async {
        await homeViewModel.getUser();
        await homeViewModel.getSummaryData();
        await homeViewModel.getTransactions();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeViewModel = context.watch<HomeViewModel>();
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 18.appHeight, horizontal: 16.appWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                CardSummaryWidget(user: homeViewModel.user,),
              SizedBox(
                height: 16.appHeight,
              ),
              const BannerInformationWidget(),
              SizedBox(
                height: 16.appHeight,
              ),
              SummaryWidget(
                showTitle: true,
                categories: homeViewModel.summary?.categories ?? [],
                total: homeViewModel.summary?.total ?? 0,
              ),
              SizedBox(
                height: 16.appHeight,
              ),
                TransactionListWidget(transactions: homeViewModel.transactions),
            ],
          ),
        ),
      ),
    );
  }
}

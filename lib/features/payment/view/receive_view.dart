import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/widgets/banner_information.dart';
import 'package:financial_manager/core/widgets/custom_button_widget.dart';
import 'package:financial_manager/features/payment/view_model/payment_view_model.dart';
import 'package:financial_manager/features/payment/widgets/custom_app_bar_widget.dart';
import 'package:financial_manager/features/payment/widgets/price_input_widget.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiveView extends StatefulWidget {
  final String userId;
  const ReceiveView({super.key, required this.userId});

  @override
  State<ReceiveView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceiveView> {
  late PaymentViewModel paymentViewModel;

  @override
  void initState() {
    paymentViewModel = context.read<PaymentViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    paymentViewModel = context.watch<PaymentViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Column(
            children: [
              const CustomAppBarWidget(
                label: 'Recebimento',
              ),
              const Spacer(),
              PriceInputWidget(
                paymentViewModel: context.read<PaymentViewModel>(),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.appWidth, vertical: 16.appHeight),
                child: CustomButtonWidget(
                  height: 50.appHeight,
                  width: double.maxFinite,
                  onPressed: () async {
                    final navigation = Navigator.of(context);
                    final overlay = Overlay.of(context);
                    final result =
                        await paymentViewModel.rec(widget.userId);
                    if (result.isSuccess) {
                      paymentViewModel.value = 0;
                      showErrorBanner(
                          overlay, result.messageCode ?? '', result);
                      navigation.pushReplacementNamed(AppRouters.home);
                    } else {
                      showErrorBanner(
                          overlay, result.messageCode ?? '', result);
                    }
                  },
                  backgroundColor: context.colors.primary,
                  label: 'Receber',
                ),
              ),
              SizedBox(
                height: 32.appHeight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

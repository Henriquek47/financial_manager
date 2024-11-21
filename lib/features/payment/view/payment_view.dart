import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/banner_information.dart';
import 'package:financial_manager/core/widgets/custom_button_widget.dart';
import 'package:financial_manager/features/payment/view_model/payment_view_model.dart';
import 'package:financial_manager/features/payment/widgets/custom_app_bar_widget.dart';
import 'package:financial_manager/features/payment/widgets/dropdown_category_widget.dart';
import 'package:financial_manager/features/payment/widgets/price_input_widget.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatefulWidget {
  final String userId;
  const PaymentView({super.key, required this.userId});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late PaymentViewModel paymentViewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    paymentViewModel = context.read<PaymentViewModel>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await paymentViewModel.getCategories(widget.userId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    paymentViewModel = context.watch<PaymentViewModel>();
    return Scaffold(
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomAppBarWidget(label: 'Pagamento'),
                  SizedBox(
                    height: 54.appHeight,
                  ),
                  Text(
                    'Valor total',
                    style: context.textStyles.headingTitleSemiBold
                        .copyWith(fontSize: 14.appFont, height: 1),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.appWidth),
                      child: PriceInputWidget(
                        paymentViewModel: paymentViewModel,
                      )),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(
                        horizontal: 12.appWidth, vertical: 16.appHeight),
                    padding: EdgeInsets.symmetric(
                        vertical: 16.appHeight, horizontal: 16.appWidth),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.appAdaptive),
                      color: context.isDarkMode
                          ? context.colors.neutralShade600
                          : context.colors.neutralWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informações',
                          style: context.textStyles.bodyText
                              .copyWith(fontSize: 14.appFont),
                        ),
                        SizedBox(
                          height: 12.appHeight,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.appHeight, horizontal: 12.appWidth),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.appAdaptive),
                            border: Border.all(
                              color: context.isDarkMode
                                  ? context.colors.neutralShade500
                                  : context.colors.neutralShade200,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Categoria',
                                style: context.textStyles.bodyText
                                    .copyWith(fontSize: 12.appFont),
                              ),
                              Divider(
                                color: context.isDarkMode
                                    ? context.colors.neutralShade500
                                    : context.colors.neutralShade200,
                              ),
                              DropdownCategoryWidget(
                                paymentViewModel: paymentViewModel,
                                categories: paymentViewModel.categories,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.appHeight,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.appHeight, horizontal: 12.appWidth),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.appAdaptive),
                            border: Border.all(
                              color: context.isDarkMode
                                  ? context.colors.neutralShade500
                                  : context.colors.neutralShade200,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: context.textStyles.bodyText
                                    .copyWith(fontSize: 12.appFont),
                              ),
                              Divider(
                                color: context.isDarkMode
                                    ? context.colors.neutralShade500
                                    : context.colors.neutralShade200,
                              ),
                              TextFormField(
                                textAlign: TextAlign.start,
                                style: context.textStyles.bodyText.copyWith(
                                  fontSize: 12.appFont,
                                ),
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText: 'Escreva aqui',
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            await paymentViewModel.payment(widget.userId);
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
                      label: 'Pagar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/banner_information.dart';
import 'package:financial_manager/core/widgets/custom_text_field.dart';
import 'package:financial_manager/features/auth/view/widgets/terms_and_use_widget.dart';
import 'package:financial_manager/features/auth/view_model/auth_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late AuthViewModel authViewModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    authViewModel = context.read<AuthViewModel>();
    super.initState();
  }

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leadingWidth: 45.appAdaptive,
        leading: const SizedBox.shrink(),
        title: Text(
          'Couze',
          style: TextStyle(
            color: context.colors.primary,
            fontSize: 14.appFont,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.appWidth, vertical: 16.appHeight),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              onChanged: _validateForm,
              child: Column(
                children: [
                  Text(
                    'Faça Login ou Crie uma conta',
                    style: context.textStyles.bodyText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                        fontSize: 30.appFont),
                  ),
                  Text(
                    'Faça seu dinheiro render com a Couze! Entre com seu email para começar',
                    style: context.textStyles.bodyTextDescription.copyWith(
                      fontSize: 14.appFont,
                    ),
                  ),
                  SizedBox(
                    height: 12.appHeight,
                  ),
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email',
                    validator: (text) {
                      return text != null && text.contains('@')
                          ? null
                          : 'Insira um email válido';
                    },
                  ),
                  SizedBox(
                    height: 12.appHeight,
                  ),
                  CustomTextField.password(
                    controller: passwordController,
                    labelText: 'Senha',
                    
                    validator: (text) {
                      return text != null && text.length >= 6
                          ? null
                          : 'Senha deve ter pelo menos 6 caracteres';
                    },
                  ),
                  SizedBox(
                    height: 12.appHeight,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: isFormValid
                          ? () async {
                              final overlay = Overlay.of(context);
                              final navigator = Navigator.of(context);
                              final result = await authViewModel.signIn(
                                emailController.text,
                                passwordController.text,
                              );
                              if (mounted) {
                                showErrorBanner(
                                    overlay, result.messageCode ?? '', result);
                              }
                              if (result.isSuccess) {
                                navigator.pushReplacementNamed(AppRouters.home);
                              }
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(isFormValid
                            ? context.colors.primary
                            : context.colors.neutralShade300),
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 16.appHeight)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.appAdaptive),
                          ),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: context.textStyles.bodyText.copyWith(
                            color: isFormValid
                                ? context.colors.neutralWhite
                                : context.colors.neutralShade100),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.appHeight,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouters.signUp),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(context.colors.secondary),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 16.appHeight),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.appAdaptive),
                          ),
                        ),
                      ),
                      child: Text(
                        'Cadastrar',
                        style: context.textStyles.bodyText
                            .copyWith(color: context.colors.neutralWhite),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const TermsAndUseWidget(),
                ],
              ),
            ),
          ),
          authViewModel.loading ? Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.black54,
            child: Center(
              child: Text('Loading...', style: context.textStyles.bodyTextSemiBold,),
            ),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

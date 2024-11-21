import 'package:financial_manager/core/constants/assets.dart';
import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/core/style/colors_app.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/core/widgets/banner_information.dart';
import 'package:financial_manager/core/widgets/custom_text_field.dart';
import 'package:financial_manager/core/widgets/icon_svg_widget.dart';
import 'package:financial_manager/features/auth/view/widgets/terms_and_use_widget.dart';
import 'package:financial_manager/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late AuthViewModel authViewModel;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isFormValid = false;

  @override
  void initState() {
    authViewModel = context.read<AuthViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconSvgWidget(
            asset: Assets.arrowLeft,
            color: context.colors.primary,
            size: 45.appAdaptive,
            onTap: () => Navigator.pop(context),
          ),
        ),
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.appWidth),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                onChanged: _validateForm,
                child: Column(
                  children: [
                    SizedBox(height: 10.appHeight),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                      validator: (text) {
                        return text != null && text.contains('@')
                            ? null
                            : 'Insira um email válido';
                      },
                    ),
                    SizedBox(height: 12.appHeight),
                    CustomTextField(
                      controller: nameController,
                      labelText: 'Name',
                      validator: (text) {
                        return text != null && text.isNotEmpty
                            ? null
                            : 'Insira um nome válido';
                      },
                    ),
                    SizedBox(height: 12.appHeight),
                    CustomTextField.password(
                      controller: passwordController,
                      labelText: 'Senha',
                      validator: (text) {
                        return text != null && text.length >= 6
                            ? null
                            : 'Senha deve ter pelo menos 6 caracteres';
                      },
                    ),
                    SizedBox(height: 12.appHeight),
                    CustomTextField.password(
                      controller: confirmPasswordController,
                      labelText: 'Confirmar senha',
                      validator: (text) {
                        return text == passwordController.text
                            ? null
                            : 'As senhas não coincidem';
                      },
                    ),
                    SizedBox(height: 12.appHeight),
                    const TermsAndUseWidget(),
                    SizedBox(height: 40.appHeight),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: isFormValid
                            ? () async {
                                final overlay = Overlay.of(context);
                                final navigator = Navigator.of(context);
                                final result = await authViewModel.signUp(
                                  nameController.text,
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
                          backgroundColor: WidgetStateProperty.resolveWith(
                            (states) => isFormValid
                                ? context.colors.primary
                                : context.colors.neutralShade300,
                          ),
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
                          'Criar Conta',
                          style: context.textStyles.bodyText.copyWith(
                            color: isFormValid
                                ? context.colors.neutralWhite
                                : context.colors.neutralShade100,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.appHeight),
                  ],
                ),
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

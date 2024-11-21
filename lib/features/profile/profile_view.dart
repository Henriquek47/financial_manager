import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/core/style/text_style_app.dart';
import 'package:financial_manager/features/auth/view/sign_up_view.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isActivit = false;

  @override
  void initState() {
    super.initState();

    // Use addPostFrameCallback to ensure the widget is inserted into the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = context.read<ThemeProvider>();
      setState(() {
        isActivit = themeProvider.themeData.brightness == Brightness.light;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch.adaptive(
            value: isActivit,
            onChanged: (value) {
              final themeProvider = context.read<ThemeProvider>();
              themeProvider.toggleTheme();
              setState(() {
                isActivit = themeProvider.themeData.brightness == Brightness.light;
              });
            },
          ),
          SizedBox(height: 16.appHeight,),
          GestureDetector(
            onTap: () async{
              final navigation = Navigator.of(context);
              await UserTokenService.instance.clearToken();
              navigation.pushReplacementNamed(AppRouters.signIn);
            },
            child: Text('Sair', style: context.textStyles.bodyText.copyWith(color: Colors.red),))
        ],
      ),
    );
  }
}

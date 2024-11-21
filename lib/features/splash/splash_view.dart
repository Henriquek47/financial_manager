import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/features/splash/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel splashViewModel;

  @override
  void initState() {
    splashViewModel = context.read<SplashViewModel>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final navigator = Navigator.of(context);

        final result = await splashViewModel.getUser();
        if (result.isSuccess) {
          navigator.pushReplacementNamed(AppRouters.home);
        } else {
          navigator.pushReplacementNamed(AppRouters.signIn);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}

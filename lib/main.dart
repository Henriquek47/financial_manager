import 'package:financial_manager/core/constants/global_context.dart';
import 'package:financial_manager/core/routes/routes.dart';
import 'package:financial_manager/features/auth/view_model/auth_view_model.dart';
import 'package:financial_manager/features/financial/view_model/financial_view_model.dart';
import 'package:financial_manager/features/home/view_model/home_view_model.dart';
import 'package:financial_manager/features/payment/view_model/payment_view_model.dart';
import 'package:financial_manager/features/transaction/view_model/transaction_view_model.dart';
import 'package:financial_manager/repositories/category_repository.dart';
import 'package:financial_manager/repositories/financial_repository.dart';
import 'package:financial_manager/repositories/payment_repository.dart';
import 'package:financial_manager/repositories/user_repository.dart';
import 'package:financial_manager/services/financial/financial_service.dart';
import 'package:financial_manager/services/user/user_service.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:financial_manager/features/splash/view_model/splash_view_model.dart';
import 'package:financial_manager/repositories/auth_repository.dart';
import 'package:financial_manager/services/http/api_client.dart';
import 'package:financial_manager/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('pt_BR');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiClient()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => UserRepository(apiClient: context.read())),
        ChangeNotifierProvider(
            create: (context) => CategoryRepository(apiClient: context.read())),
        ChangeNotifierProvider(
            create: (context) =>
                FinancialRepository(apiClient: context.read())),
        ChangeNotifierProvider(
            create: (context) => UserService(userRepository: context.read())),
        ChangeNotifierProvider(
            create: (context) => PaymentRepository(apiClient: context.read())),
        ChangeNotifierProvider(
            create: (context) =>
                FinancialService(financialRepository: context.read())),
        ChangeNotifierProvider(
            create: (context) => HomeViewModel(
                financialService: context.read(), userService: context.read())),
        ChangeNotifierProvider(
            create: (context) => TransactionViewModel(
                financialService: context.read(), userService: context.read())),
        ChangeNotifierProvider(
            create: (context) => FinancialViewModel(
                financialService: context.read(), userService: context.read())),
        ChangeNotifierProvider(
            create: (context) => PaymentViewModel(
                paymentRepository: context.read(),
                categoryRepository: context.read())),
        ChangeNotifierProvider(
          create: (context) => AuthRepository(
            apiClient: context.read<ApiClient>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashViewModel(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext? context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).themeData,
          onGenerateRoute: generateRoute,
          initialRoute: AppRouters.splash,
          navigatorKey: GlobalContext.instance.navigatorKey,
          home: Container(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/get_it/get_it.dart';
import 'package:tasneem_sba7ie/core/router/app_router.dart';
import 'package:tasneem_sba7ie/core/theme/theme_management.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();
  getItSetup();
  // await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X size, adjust as needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Tasneem Sba7ie',
          theme: ThemeManagement.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          // Localizations for Arabic and English
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('ar', ''), // Arabic
          ],
          locale: const Locale('ar', 'AR'), // Default to Arabic
        );
      },
    );
  }
}

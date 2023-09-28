import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yehyefirebasee/Providers/theme_provider.dart';
import 'package:yehyefirebasee/screens/splash_screen.dart';
import 'Cache/cache_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Providers/language_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheController().initCache();
  ///Firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider() ,),
            ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider() ,)

          ],
          child: Consumer<LanguageProvider>(
            builder: (context, value, child) {
              return const MyMaterialApp();
            },
          ),
        );
      },

    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      locale: Locale(Provider
          .of<LanguageProvider>(context)
          .language),
      supportedLocales: const [
        Locale('en'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
  }

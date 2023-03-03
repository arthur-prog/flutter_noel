import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_noel/src/features/screens/home/home_screen.dart';
import 'package:flutter_noel/src/features/screens/product/admin/add_product/add_product_screen.dart';
import 'package:flutter_noel/src/features/screens/user/user_adress_modify_screen.dart';
import 'package:flutter_noel/src/features/screens/user/user_login_screen.dart';
import 'package:flutter_noel/src/features/screens/user/user_registration_screen.dart';
import 'package:flutter_noel/src/features/screens/product/admin/product_list/product_list_screen.dart';
import 'package:flutter_noel/src/features/screens/product/products_list/products_list_screen.dart';
import 'package:flutter_noel/src/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ProductsListScreen(),
    );
  }
}

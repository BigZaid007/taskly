import 'package:Notex/services/theme_services.dart';
import 'package:Notex/ui/splashScreen.dart';
import 'package:Notex/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'db/db_helper.dart';
import 'ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.creatDatabase();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'Notex',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

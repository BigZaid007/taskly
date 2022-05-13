import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeServices {

   final GetStorage _box=GetStorage();
   final _key='isDarkMode';

   bool _loadTheme(){
     return _box.read(_key) ?? false;
   }
   void _saveTheme(bool isDark) async{
     await _box.write(_key, isDark);
   }

   ThemeMode get theme => _loadTheme()?ThemeMode.dark:ThemeMode.light;

   void switchTheme()
   {

    Get.changeThemeMode(_loadTheme()?ThemeMode.light:ThemeMode.dark);
    _saveTheme(!_loadTheme());

   }




}

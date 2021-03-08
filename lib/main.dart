import 'package:flutter/material.dart';
import 'package:social_media_app/services/shared_preferences_service.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    themeMode: await SharedPreferencesService.getThemeMode(),
  ));
}

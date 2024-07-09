import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/providers/json_decode_provider.dart';
import 'controllers/providers/theme_provider.dart';
import 'models/theme_model.dart';
import 'views/screens/Details_Page.dart';
import 'views/screens/Favorites_Page.dart';
import 'views/screens/Home_Page.dart';
import 'views/screens/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool('isDark') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: isDark,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => JsonDecodeProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          'home_page': (context) => const HomePage(),
          'details_page': (context) => const DetailsPage(),
          'favorites_page': (context) => const FavoritesPage(),
        },
      ),
    ),
  );
}

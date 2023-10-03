import 'package:app_hemat/data/database.dart';
import 'package:app_hemat/provider/themeProvider.dart';
import 'package:app_hemat/screen/introduction_screen.dart';

import 'package:app_hemat/screen/navigasi.dart';
import 'package:app_hemat/theme/dark_theme.dart';
import 'package:app_hemat/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Mengecek apakah ada nama panggilan yang sudah disimpan dalam SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? namaPanggilan = prefs.getString('nama_panggilan');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // Menentukan layar yang akan ditampilkan berdasarkan kondisi
  Widget initialScreen = (namaPanggilan != null && namaPanggilan.isNotEmpty)
      ? const Navigasi()
      : const IntroductionScreen();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDb>(
          create: (context) => AppDb(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Diary Dompet',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: themeProvider.isDarkModeEnabled ? darkTheme : lightTheme,
            darkTheme: darkTheme,
            home: initialScreen,
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Diary Dompet',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const IntroductionScreen());
  }
}

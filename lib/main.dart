import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:your_friend/SplashScreen/splash_screen.dart';
import 'package:your_friend/Theme/theme_model.dart';

import 'key.dart';

void main() {
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // ChangeNotifier handle the themeModel (All the data that is present in the ThemeModel Class)
        create: (_) => ThemeModel(),
        //CONSUMER is an widget when ever the theme change it rebuild the app states
        child: Consumer(
          builder: (context, ThemeModel themeNotifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme:
                  themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
              // It define that is DarkTheme is ture in the ThemeModel then it is
              // DarkTheme otherwise it will be remain Light Theme .
              //Means that jo Theme Model ke state ho ge woh he app ka theme ke
              //State ho gee.
              home: SplashScreen(),
            );
          },
        ));
  }
}

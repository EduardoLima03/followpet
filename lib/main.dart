import 'package:flutter/material.dart';
import 'package:followpet_alfa/utils/colors.dart';
import 'package:followpet_alfa/views/pages/details_page.dart';
import 'package:followpet_alfa/views/pages/form_pet_page.dart';
import 'package:followpet_alfa/views/pages/home_page.dart';
import 'package:followpet_alfa/views/pages/splash_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FollowPet Alfa',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primary,
        accentColor: fourth,
        backgroundColor: gray50,
        cardTheme: CardTheme(shadowColor: gray50),
        textTheme: TextTheme(bodyText2: TextStyle(color: primary)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: second,
        textTheme: TextTheme(bodyText2: TextStyle(color: second)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreenPage(),
        '/home': (context) => HomePage(),
        '/form': (context) => FormPetPage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}

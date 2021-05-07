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
        primaryColor: primary,
        accentColor: fourth,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashScreenPage(),
        '/home': (context) => HomePage(),
        '/form': (context) => FormPetPage(),
        '/details': (context) => DetailsPage(),

      },
    );
  }
}
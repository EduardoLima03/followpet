import 'package:flutter/material.dart';
import 'package:followpet_alfa/data/database_helper.dart';
import 'package:followpet_alfa/utils/colors.dart';
import 'package:followpet_alfa/utils/images.dart';

class SplashScreenPage extends StatelessWidget {
  DatabaseHelper db = DatabaseHelper();
  var context;

  @override
  initState(){
    _durationPage().then((value) {
      value != false ? _navigatorHome() : _navigatorCreatePet();
    });
  }

  Future<bool> _durationPage() async{
    await Future.delayed(Duration(milliseconds: 5000), () {});
    var numberPet;
    /// vai retorna true se exisite pet no banco de dados
    /// false se nao existir
    db.getNumber().then((value) {
      numberPet = value;
    });
    return numberPet > 0? true: false;
  }

  void _navigatorCreatePet(){
    
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: context), (route) => false);
  }

  void _navigatorHome(){
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    ///gambiarra
    this.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(LOGO),
            SizedBox(height: 28.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Follow',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Pet',
                  style: TextStyle(
                    color: second,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text('Controle as vacinas de seus pets',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50,),
            Text('Alfa',
            style: TextStyle(
              color: fourth,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
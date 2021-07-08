import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:followpet_alfa/data/database_helper.dart';
import 'package:followpet_alfa/utils/colors.dart';
import 'package:followpet_alfa/utils/images.dart';
import 'package:followpet_alfa/utils/version_code_si.dart';
import 'package:package_info/package_info.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  DatabaseHelper db = DatabaseHelper();
  int numberPet;

  VersionCodeSi _versionCodeSi = VersionCodeSi();// para manipular aa versao
  

  ///informaçoes da versao
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  // ignore: must_call_super
  initState() {
    _initPackageInfo();
    db.getNumber().then((value) {
      numberPet = value;
    });

    _durationPage().then((value) {
      value != false ? _navigatorHome() : _navigatorCreatePet();
    });
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      String vers = info.version.toString();// vers vai receber o campo de versao do projeto
      if(vers.isNotEmpty)// se ela nao tiver vazia vai ser salva no sigleton
        _versionCodeSi.Version = vers;
    });
  }

  Future<bool> _durationPage() async{
    await Future.delayed(Duration(milliseconds: 3000), () {});
    
    /// vai retorna true se exisite pet no banco de dados
    /// false se nao existir
    
    return numberPet > 0? true: false;
  }

  void _navigatorCreatePet(){
    Navigator.pushNamedAndRemoveUntil(context, '/form', (route) => false);
  }

  void _navigatorHome(){
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(LOGO, width: 181.0, height: 181.0,),
            SizedBox(height: 28.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Follow',
                  style: TextStyle(
                    color: primary,
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
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
            SizedBox(height: 50,),
            Text('${_versionCodeSi.Version} Alfa',
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
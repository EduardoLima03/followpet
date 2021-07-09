import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:followpet_alfa/utils/images.dart';
import 'package:followpet_alfa/utils/version_code_si.dart';

class DrawerWidgets extends StatelessWidget {
  String _version;
  DrawerWidgets(this._version);

  VersionCodeSi versionCodeSi = VersionCodeSi();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 83.0,
                    width: 83.0,
                    child: SvgPicture.asset(ICONPERSON),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alfa Test",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "alfa@followpet.br",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Avalie!",
              style: TextStyle(fontSize: 16),
            ),
            onTap: null,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Versão ${versionCodeSi.Version}',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

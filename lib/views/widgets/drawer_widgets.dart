import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:followpet_alfa/utils/images.dart';

class DrawerWidgets extends StatelessWidget {
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
                    height: 80.0,
                    width: 80.0,
                    child: SvgPicture.asset(ICONPERSON),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Alfa Test"), Text("alfa@followpet.br")],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("Avalie!"),
            onTap: null,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:followpet_alfa/data/database_helper.dart';
import 'package:followpet_alfa/model/pet_model.dart';
import 'package:followpet_alfa/utils/images.dart';
import 'package:followpet_alfa/utils/strings/pt_br.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    final PetModel _petInfo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePageDetails),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _actionBar(
                    context: context,
                    mensagem: titleAlertUpdate,
                    petU: _petInfo);
              }),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _actionBar(
                  context: context,
                  mensagem: titleAlertDelete,
                  id: _petInfo.IdPet);
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return layoutSm(_petInfo);
        } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 992) {
          return layoutMd();
        } else if (constraints.maxWidth >= 992 && constraints.maxWidth < 1200) {
          return layoutLg();
        } else if (constraints.maxWidth >= 1200) {
          return layoutXl();
        } else {
          return layoutDefult();
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }

  Widget layoutSm(PetModel pet) {
    return ListView(
      padding: EdgeInsets.fromLTRB(60, 36, 60, 0),
      children: [
        Container(
          width: 159.0,
          height: 159.0,
          child: Image.asset(pet.SpeciePet == 'dog' ? ICONDOG : ICONCAT),
        ),
        SizedBox(
          height: 55,
        ),
        Row(
          children: [
            field(pet.NamePet, fieldLabelName),
            Expanded(
              child: SizedBox(),
            ),
            field(pet.DateOfBirthPet, fieldLabelDate),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            field(pet.SpeciePet, fieldLabelSpacie),
            Expanded(
              child: SizedBox(),
            ),
            field(pet.GenderPet, fieldLabelGender)
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            field(pet.BreedPet, fieldLabelBreed),
            Expanded(child: SizedBox()),
            field("Second Breed", fieldLabelBreed)
          ],
        ),
        //SizedBox(height: 19,),
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        // TODO start section vaccine
        Text(
          'Vacinas',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Container(
              width: 115,
              child: Text(
                pet.DateOfBirthPet,
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: 115,
              child: Text(
                "Cinomose",
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 115,
              child: Text(
                pet.DateOfBirthPet,
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: 115,
              child: Text(
                "Cinomose",
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
          ],
        ),
        // end section vaccine
        //TODO start section vermifuge
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          'Vermifugos',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Container(
              width: 115,
              child: Text(
                pet.DateOfBirthPet,
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: 115,
              child: Text(
                "Ivermectina",
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    //Fim ListView
  }

  // end LayoutSM
  Container field(String value, String label) {
    return Container(
      width: 115,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  // Fim LayoutSM
  Widget layoutMd() {
    return Container(
      child: Text('LayoutMD'),
    );
  }

  // Fim LayoutMD
  Widget layoutLg() {
    return ListView(
      padding: EdgeInsets.fromLTRB(24.0, 36.0, 24.0, 0.0),
      children: [
        Container(
          child: Image.asset(ICONDOG),
        ),
      ],
    );
    //Fim ListView
  }

  // Fim LayoutLG
  Widget layoutXl() {
    return Container(
      child: Text('LayoutXl'),
    );
  }

  // Fim LayoutXL
  Widget layoutDefult() {
    return Container(
      child: Center(
        child: Text(layoutDefultM),
      ),
    );
  }
  // Fim LayoutDefult

  /// Esse metodo será responsavel por exibir o alert ao usuario perguntado
  /// se ela deseja deleta o pet
  _actionBar({BuildContext context, String mensagem, int id, PetModel petU}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(mensagem),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(titleButtonRefuse)),
              TextButton(
                  onPressed: () {
                    if (id != null) {
                      db.delete(id).then((value) {
                        if (value > 0) {
                          Navigator.popAndPushNamed(context, '/home',
                              result: value);
                        }
                      });
                    } else {
                      Navigator.pushNamed(context, '/form', arguments: petU);
                      //Navigator.of(context).pop();
                    }
                  },
                  child: Text(titleButtonConfirms)),
            ],
          );
        });
  }
  //fim do ShowDialog
}

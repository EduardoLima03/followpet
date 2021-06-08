import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:followpet_alfa/data/database_helper.dart';
import 'package:followpet_alfa/model/pet_model.dart';
import 'package:followpet_alfa/utils/images.dart';
import 'package:followpet_alfa/utils/strings/pt_br.dart';
import 'package:followpet_alfa/views/widgets/field_widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DatabaseHelper db = DatabaseHelper();
  final _detailsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final PetModel _petInfo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _detailsKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(titlePageDetails+ ' - ' + _petInfo.NamePet),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _actionBar(
                    context: context, title: titleAlertUpdate, petU: _petInfo);
              }),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _actionBar(
                  context: context,
                  title: titleAlertDelete,
                  id: _petInfo.IdPet);
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return layoutSm(_petInfo);
        } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 992) {
          return layoutMd(_petInfo);
        } else if (constraints.maxWidth >= 992 && constraints.maxWidth < 1200) {
          return layoutLg(_petInfo);
        } else if (constraints.maxWidth >= 1200) {
          return layoutXl(_petInfo);
        } else {
          return layoutDefult();
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _actionBar(
              context: context,
              title: 'Pesquisa',
              message:
                  'Ao clicar em sim voce será direcionado para o formulario de pesquisa',
              url: 'https://eduardolima03.github.io/followpet/');
        },
      ),
    );
  }

  // end LayoutSM
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
        /*FieldWidgets(
          label1: 'Nome',
          value1: pet.NamePet,
          label2: 'Data',
          value2: pet.DateOfBirthPet,
          sized: 18,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 18,
          label1: 'Especie',
          value1: pet.SpeciePet,
          label2: 'Ganero',
          value2: pet.GenderPet,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 18,
          label1: 'Breed',
          value1: pet.BreedPet,
          label2: 'Breed',
          value2: 'Second breed',
        ),
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),*/
        // start section vaccine
        Text(
          'Vacinas',
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 18,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 18,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Anterabica',
          sized: 18,
        ),
        // end section vaccine
        //start section vermifuge
        SizedBox(height: 50,),
        Text(
          'Vermifugos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1.color),
        ),
        SizedBox(height: 30),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 18,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 18,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 18,
        ),
      ],
    );
  }
  // Fim LayoutSM

  Widget layoutMd(PetModel pet) {
    return ListView(
      padding: EdgeInsets.fromLTRB(60, 36, 60, 0),
      children: [
        Container(
          width: 180.0,
          height: 180.0,
          child: Image.asset(pet.SpeciePet == 'dog' ? ICONDOG : ICONCAT),
        ),
        SizedBox(
          height: 55,
        ),
        FieldWidgets(
          label1: 'Nome',
          value1: pet.NamePet,
          label2: 'Data',
          value2: pet.DateOfBirthPet,
          sized: 20,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 20,
          label1: 'Especie',
          value1: pet.SpeciePet,
          label2: 'Ganero',
          value2: pet.GenderPet,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 20,
          label1: 'Breed',
          value1: pet.BreedPet,
          label2: 'Breed',
          value2: 'Second breed',
        ),
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        // start section vaccine
        Text(
          'Vacinas',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 20,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 20,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Anterabica',
          sized: 20,
        ),
        // end section vaccine
        //start section vermifuge
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          'Vermifugos',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 30),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 20,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 20,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 20,
        ),
      ],
    );
  }
  // Fim LayoutMD

  Widget layoutLg(PetModel pet) {
    return ListView(
      padding: EdgeInsets.fromLTRB(120, 36, 120, 0),
      children: [
        Container(
          width: 250.0,
          height: 250.0,
          child: Image.asset(pet.SpeciePet == 'dog' ? ICONDOG : ICONCAT),
        ),
        SizedBox(
          height: 55,
        ),
        FieldWidgets(
          label1: 'Nome',
          value1: pet.NamePet,
          label2: 'Data',
          value2: pet.DateOfBirthPet,
          sized: 30,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 30,
          label1: 'Especie',
          value1: pet.SpeciePet,
          label2: 'Ganero',
          value2: pet.GenderPet,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 30,
          label1: 'Breed',
          value1: pet.BreedPet,
          label2: 'Breed',
          value2: 'Second breed',
        ),
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        // start section vaccine
        Text(
          'Vacinas',
          style: TextStyle(fontSize: 38),
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 30,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 30,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Anterabica',
          sized: 30,
        ),
        // end section vaccine
        //start section vermifuge
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          'Vermifugos',
          style: TextStyle(fontSize: 38),
        ),
        SizedBox(height: 30),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 30,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 30,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 30,
        ),
      ],
    );
    //Fim ListView
  }

  // Fim LayoutLG
  Widget layoutXl(PetModel pet) {
    return ListView(
      padding: EdgeInsets.fromLTRB(120, 36, 120, 0),
      children: [
        Container(
          width: 450.0,
          height: 450.0,
          child: Image.asset(pet.SpeciePet == 'dog' ? ICONDOG : ICONCAT),
        ),
        SizedBox(
          height: 55,
        ),
        FieldWidgets(
          label1: 'Nome',
          value1: pet.NamePet,
          label2: 'Data',
          value2: pet.DateOfBirthPet,
          sized: 40,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 40,
          label1: 'Especie',
          value1: pet.SpeciePet,
          label2: 'Ganero',
          value2: pet.GenderPet,
        ),
        SizedBox(
          height: 6,
        ),
        FieldWidgets(
          sized: 40,
          label1: 'Breed',
          value1: pet.BreedPet,
          label2: 'Breed',
          value2: 'Second breed',
        ),
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        //start section vaccine
        Text(
          'Vacinas',
          style: TextStyle(fontSize: 48),
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 40,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Cinomose',
          sized: 40,
        ),
        SizedBox(height: 20),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Anterabica',
          sized: 40,
        ),
        // end section vaccine
        //start section vermifuge
        Container(
          child: Divider(
            height: 30,
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          'Vermifugos',
          style: TextStyle(fontSize: 48),
        ),
        SizedBox(height: 30),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 40,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 40,
        ),
        SizedBox(
          height: 20,
        ),
        FieldWidgets(
          value1: pet.DateOfBirthPet,
          value2: 'Invermectina',
          sized: 40,
        ),
      ],
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
  _actionBar(
      {BuildContext context,
      String title,
      int id,
      PetModel petU,
      String url,
      String message}) {
    if (url != null) {
      return showDialog(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(titleButtonRefuse)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(titleButtonConfirms)),
              ],
            );
          });
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
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

 /* Future _durationAlert() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
  }*/
}

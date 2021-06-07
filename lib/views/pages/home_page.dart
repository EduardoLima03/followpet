import 'package:flutter/material.dart';
import 'package:followpet_alfa/data/database_helper.dart';
import 'package:followpet_alfa/model/pet_model.dart'; 
import 'package:followpet_alfa/utils/strings/pt_br.dart';
import 'package:followpet_alfa/views/widgets/card_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper();
  List<PetModel> _pets = [];

  @override
  void initState() {
    super.initState();
    _getAllPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(titlePageHome),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return layoutSm();
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
        onPressed: () {
          _showCadastrapet();
        },
      ),
    );
  }

  Widget layoutSm() {
    if (_pets.length > 0) {
      return ListView.builder(
          padding: EdgeInsets.only(left:33.00, right: 33.00,top: 10.0),
          itemCount: _pets.length,
          itemBuilder: (context, index) {
            return CardWidgets(
                PetModel.fromMap(_pets[index].toMap()), _showCadastrapet);
          });
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(left:33.00, right: 33.00),
          child: Text('Não tem pet cadastrado!!. '
              'aperte no botão para cadastra agora'),
        ),
      );
    }
  }

  Widget layoutMd() {
    if (_pets.length > 0) {
      return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.only(left: 24, right: 24),
        crossAxisSpacing: 10.0,
        children: List<Widget>.generate(
          _pets.length,
          (index) => CardWidgets(
              PetModel.fromMap(_pets[index].toMap()), _showCadastrapet),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.00),
          child: Text(messagePetZero),
        ),
      );
    }
  }

  Widget layoutLg() {
    if (_pets.length > 0) {
      return GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.only(left: 24, right: 24),
        crossAxisSpacing: 10.0,
        children: List<Widget>.generate(
          _pets.length,
          (index) => CardWidgets(
              PetModel.fromMap(_pets[index].toMap()), _showCadastrapet),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.00),
          child: Text(messagePetZero),
        ),
      );
    }
  }

  Widget layoutXl() {
    if (_pets.length > 0) {
      return GridView.count(
        crossAxisCount: 4,
        padding: EdgeInsets.only(left: 24, right: 24),
        crossAxisSpacing: 10.0,
        children: List<Widget>.generate(
          _pets.length,
          (index) => CardWidgets(
              PetModel.fromMap(_pets[index].toMap()), _showCadastrapet),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.00),
          child: Text(messagePetZero),
        ),
      );
    }
  }

  Widget layoutDefult() {
    return Container(child: Center(child: Text(layoutDefultM),),);
  }

  /// Codigo presente na aula 104 do curso
  /// Criação de Apps Android e iOS com Flutter 2021-Crie 14 Apps
  /// Tem a função de recarregar a lista de pets para ser exibido
  /// posterio a um insert na tela de cadastro
  void _showCadastrapet({PetModel petModel}) async {

    if(petModel != null){
      final recPet =
        await Navigator.pushNamed(context, '/details', arguments: petModel);
      if (recPet != null) {
        /// Sempre averá o retor do pet, sendo novo ou alterado. com
        /// isso a lista de pet sera atualizada
        /*if (petModel != null) {
          await db.update(recPet);

        }else{
          await db.insert(recPet);
        }*/
        _getAllPets();
      }
    }else{
      final recPet =
          await Navigator.pushNamed(context, '/form', arguments: petModel);
      if (recPet != null) {
        /// Sempre averá o retor do pet, sendo novo ou alterado. com
        /// isso a lista de pet sera atualizada
        /*if (petModel != null) {
          await db.update(recPet);

        }else{
          await db.insert(recPet);
        }*/
        _getAllPets();
      }
    }
  }

  void _getAllPets() {
    db.getallPet().then((value) {
      setState(() {
        _pets = value;
      });
    });
  }
}

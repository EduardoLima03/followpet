import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:followpet_alfa/database/sqlite/dao/impl/pet_dao_impl.dart';
import 'package:followpet_alfa/model/entities/pet_model.dart';
import 'package:followpet_alfa/utils/images.dart';
import 'package:followpet_alfa/utils/strings/pt_br.dart';
import 'package:followpet_alfa/views/widgets/picture_widgets.dart';

class FormPetPage extends StatefulWidget {
  @override
  _FormPetPageState createState() => _FormPetPageState();
}

class _FormPetPageState extends State<FormPetPage> {
  //DatabaseHelper db = DatabaseHelper();

  final _formkey = GlobalKey<FormState>();
  PetModel pet = new PetModel.empty();
  int petNumber;

  final _controllerDate = TextEditingController();
  String _specieDelectedValue;
  String _genderDelectedValue;

  @override
  Widget build(BuildContext context) {
    final PetModel _petInfo = ModalRoute.of(context).settings.arguments;
    if (_petInfo != null) {
      setState(() {
        _genderDelectedValue = _petInfo.GenderPet;
        _specieDelectedValue = _petInfo.SpeciePet;
        _controllerDate.text = _petInfo.DateOfBirthPet;
      });
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(_petInfo != null ? titlePageUpdates : titlePageRegister),
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
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          _formkey.currentState.validate();
          if (_specieDelectedValue.isEmpty || _genderDelectedValue.isEmpty) {
            log("nao salvo", name: "validação");
          } else if (_petInfo != null) {
            ///se a tela receber um pet o update do animal
            _formkey.currentState.save();
            pet.SpeciePet = _specieDelectedValue;
            pet.GenderPet = _genderDelectedValue;
            pet.IdPet = _petInfo.IdPet;
            PetDaoImpl().update(pet).then((value) {
              if (value > 0) showAlertDialog(context, messageAlertUpd);
            });
          } else {
            /// se não receber o pet, sera um no entao insert
            _formkey.currentState.save();
            pet.SpeciePet = _specieDelectedValue;
            pet.GenderPet = _genderDelectedValue;

            PetDaoImpl().insert(pet).then((value) {
              pet.IdPet = value;
              if (value > 0) showAlertDialog(context, messageAlertNew);
            });
          }
        },
      ),*/
    );
  }

  Widget layoutSm(PetModel recPet) {
    return ListView(
      padding: EdgeInsets.only(top: 30.0, left: 35.0, right: 35.0),
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              /// TODO refazer o teste de icone
              /// no lugar do familia é para saber se objeto tem foto, a foto de ser
              /// inserida na hora de salvar, se nao tive foto, sava o icon da familia
              PictureWidgets(
                  138,
                  138,
                  recPet != null
                      ? _specieDelectedValue == "dog"
                          ? ICONDOG
                          : ICONCAT
                      : ICONPHOTO),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: recPet != null ? recPet.NamePet : null,
                decoration: InputDecoration(
                    labelText: fieldLabelName,
                    icon: Icon(Icons.person),
                    border: UnderlineInputBorder(),
                    focusColor: Theme.of(context).accentColor),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.NamePet = value,
              ),
              TextFormField(
                controller: _controllerDate,
                decoration: InputDecoration(
                  labelText: fieldLabelDate,
                  icon: Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.DateOfBirthPet = value,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050))
                      .then((value) {
                    setState(() {
                      _controllerDate.text =
                          "${value.toString()[0]}${value.toString()[1]}${value.toString()[2]}${value.toString()[3]}${value.toString()[4]}${value.toString()[5]}${value.toString()[6]}${value.toString()[7]}${value.toString()[8]}${value.toString()[9]}";
                    });
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelSpacie,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "dog",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Dog",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Radio(
                          value: "cat",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Cat",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelGender,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: famale,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          famale,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Radio(
                            value: male,
                            groupValue: _genderDelectedValue,
                            onChanged: _genderChanges,
                            activeColor:
                                Theme.of(context).textTheme.bodyText2.color),
                        Text(
                          male,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // fim dos radio
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelBreed,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 1",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 2",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17,
              ),
              ElevatedButton(
                onPressed: () {
                  _formkey.currentState.validate();
                  if (_specieDelectedValue.isEmpty ||
                      _genderDelectedValue.isEmpty) {
                    log("nao salvo", name: "validação");
                  } else if (recPet != null) {
                    ///se a tela receber um pet o update do animal
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;
                    pet.IdPet = recPet.IdPet;
                    PetDaoImpl().update(pet).then((value) {
                      if (value > 0) showAlertDialog(context, messageAlertUpd);
                    });
                  } else {
                    /// se não receber o pet, sera um no entao insert
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;

                    PetDaoImpl().insert(pet).then((value) {
                      pet.IdPet = value;
                      if (value > 0) showAlertDialog(context, messageAlertNew);
                    });
                  }
                },
                child: Text(
                  "Salva",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //fim do LayoutSM

  Widget layoutMd(PetModel recPet) {
    return ListView(
      padding: EdgeInsets.only(top: 65.0, left: 80.0, right: 80.0),
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              Text("Layout MD"),
              Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset(recPet != null
                    ? _specieDelectedValue == "dog"
                        ? ICONDOG
                        : ICONCAT
                    : ICONPHOTO),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: recPet != null ? recPet.NamePet : null,
                decoration: InputDecoration(
                  labelText: fieldLabelName,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.NamePet = value,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _controllerDate,
                decoration: InputDecoration(
                  labelText: fieldLabelDate,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.DateOfBirthPet = value,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050))
                      .then((value) {
                    setState(() {
                      _controllerDate.text =
                          "${value.toString()[0]}${value.toString()[1]}${value.toString()[2]}${value.toString()[3]}${value.toString()[4]}${value.toString()[5]}${value.toString()[6]}${value.toString()[7]}${value.toString()[8]}${value.toString()[9]}";
                    });
                  });
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelSpacie,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "dog",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Dog",
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Radio(
                          value: "cat",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Cat",
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelGender,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: famale,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          famale,
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Radio(
                          value: male,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          male,
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // fim dos radio
              SizedBox(
                height: 16,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelBreed,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 1",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 2",
                              focusColor: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _formkey.currentState.validate();
                  if (_specieDelectedValue.isEmpty ||
                      _genderDelectedValue.isEmpty) {
                    log("nao salvo", name: "validação");
                  } else if (recPet != null) {
                    ///se a tela receber um pet o update do animal
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;
                    pet.IdPet = recPet.IdPet;
                    PetDaoImpl().update(pet).then((value) {
                      if (value > 0) showAlertDialog(context, messageAlertUpd);
                    });
                  } else {
                    /// se não receber o pet, sera um no entao insert
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;

                    PetDaoImpl().insert(pet).then((value) {
                      pet.IdPet = value;
                      if (value > 0) showAlertDialog(context, messageAlertNew);
                    });
                  }
                },
                child: Text(
                  "Salva",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //fim do LayoutMD

  Widget layoutLg(PetModel recPet) {
    return ListView(
      padding: EdgeInsets.only(top: 30.0, left: 24.0, right: 24.0),
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                height: 160,
                width: 160,
                child: SvgPicture.asset(recPet != null
                    ? _specieDelectedValue == "dog"
                        ? ICONDOG
                        : ICONCAT
                    : ICONPHOTO),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: recPet != null ? recPet.NamePet : null,
                decoration: InputDecoration(
                  labelText: fieldLabelName,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.NamePet = value,
              ),
              TextFormField(
                controller: _controllerDate,
                decoration: InputDecoration(
                  labelText: fieldLabelDate,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.DateOfBirthPet = value,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050))
                      .then((value) {
                    setState(() {
                      _controllerDate.text =
                          "${value.toString()[0]}${value.toString()[1]}${value.toString()[2]}${value.toString()[3]}${value.toString()[4]}${value.toString()[5]}${value.toString()[6]}${value.toString()[7]}${value.toString()[8]}${value.toString()[9]}";
                    });
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelSpacie,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "dog",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Dog",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Radio(
                          value: "cat",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Cat",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelGender,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: famale,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          famale,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Radio(
                          value: male,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          male,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // fim dos radio
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelBreed,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 1",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 2",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17,
              ),
              ElevatedButton(
                onPressed: () {
                  _formkey.currentState.validate();
                  if (_specieDelectedValue.isEmpty ||
                      _genderDelectedValue.isEmpty) {
                    log("nao salvo", name: "validação");
                  } else if (recPet != null) {
                    ///se a tela receber um pet o update do animal
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;
                    pet.IdPet = recPet.IdPet;
                    PetDaoImpl().update(pet).then((value) {
                      if (value > 0) showAlertDialog(context, messageAlertUpd);
                    });
                  } else {
                    /// se não receber o pet, sera um no entao insert
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;

                    PetDaoImpl().insert(pet).then((value) {
                      pet.IdPet = value;
                      if (value > 0) showAlertDialog(context, messageAlertNew);
                    });
                  }
                },
                child: Text(
                  "Salva",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ),
      ],
    );
  }
  //fim do LayoutLG

  Widget layoutXl(PetModel recPet) {
    return ListView(
      padding: EdgeInsets.only(top: 30.0, left: 24.0, right: 24.0),
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                height: 160,
                width: 160,
                child: SvgPicture.asset(recPet != null
                    ? _specieDelectedValue == "dog"
                        ? ICONDOG
                        : ICONCAT
                    : ICONPHOTO),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: recPet != null ? recPet.NamePet : null,
                decoration: InputDecoration(
                  labelText: fieldLabelName,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.NamePet = value,
              ),
              TextFormField(
                controller: _controllerDate,
                decoration: InputDecoration(
                  labelText: fieldLabelDate,
                  labelStyle:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return fieldValidationM;
                  }
                  return null;
                },
                onSaved: (value) => pet.DateOfBirthPet = value,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050))
                      .then((value) {
                    setState(() {
                      _controllerDate.text =
                          "${value.toString()[0]}${value.toString()[1]}${value.toString()[2]}${value.toString()[3]}${value.toString()[4]}${value.toString()[5]}${value.toString()[6]}${value.toString()[7]}${value.toString()[8]}${value.toString()[9]}";
                    });
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelSpacie,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "dog",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Dog",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Radio(
                          value: "cat",
                          groupValue: _specieDelectedValue,
                          onChanged: _specieChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          "Cat",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelGender,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: famale,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          famale,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Radio(
                          value: male,
                          groupValue: _genderDelectedValue,
                          onChanged: _genderChanges,
                          activeColor:
                              Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Text(
                          male,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // fim dos radio
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldLabelBreed,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 1",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue:
                                recPet != null ? recPet.BreedPet : null,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Breend 2",
                              focusColor: Theme.of(context).accentColor,
                            ),
                            validator: (value) {
                              if (value.isEmpty) return fieldValidationM;

                              return null;
                            },
                            onSaved: (newValue) => pet.BreedPet = newValue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17,
              ),
              ElevatedButton(
                onPressed: () {
                  _formkey.currentState.validate();
                  if (_specieDelectedValue.isEmpty ||
                      _genderDelectedValue.isEmpty) {
                    log("nao salvo", name: "validação");
                  } else if (recPet != null) {
                    ///se a tela receber um pet o update do animal
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;
                    pet.IdPet = recPet.IdPet;
                    PetDaoImpl().update(pet).then((value) {
                      if (value > 0) showAlertDialog(context, messageAlertUpd);
                    });
                  } else {
                    /// se não receber o pet, sera um no entao insert
                    _formkey.currentState.save();
                    pet.SpeciePet = _specieDelectedValue;
                    pet.GenderPet = _genderDelectedValue;

                    PetDaoImpl().insert(pet).then((value) {
                      pet.IdPet = value;
                      if (value > 0) showAlertDialog(context, messageAlertNew);
                    });
                  }
                },
                child: Text(
                  "Salva",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ],
          ),
        ),
      ],
    );
  }
  //fim do LayoutXL

  Widget layoutDefult() {
    return Container(
      child: Center(
        child: Text(layoutDefultM),
      ),
    );
  }
  //fim do LayoutDefult

  /// Metodos responsavel para salva a
  /// escolha do radiobutton do usuario
  void _specieChanges(String value) {
    setState(() {
      _specieDelectedValue = value;
    });
  }
  //fim do SpecieChanges

  void _genderChanges(String value) {
    setState(() {
      _genderDelectedValue = value;
    });
  }
  //fim do GenderChanges

  /// Metodo usado para mostra o usuario que
  /// os dados foram salvo ou alterado
  showAlertDialog(BuildContext context, String mensagem) {
    Widget okButton = TextButton(
      child: Text('OK'),
      onPressed: () {
        // faz o retorna para tela principal
        // pasando um pet (novo ou atualizado) para ser tratado na tela
        // principal
        Navigator.popAndPushNamed(context, '/home', result: pet);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(mensagem),
      content: Text(contentAlert),
      actions: [
        okButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
  //fim do ShowDialog
}

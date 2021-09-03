import 'package:followpet_alfa/utils/attributes_string.dart';

class PetModel {
  int _idPet;
  String _name;
  String _dateOfBirth;
  String _gender;
  String _species;
  String _breed;

  PetModel.empty();

  PetModel(this._idPet, this._name, this._dateOfBirth, this._gender,
      this._species, this._breed);

  PetModel.fromMap(Map<String, dynamic> obj) {
    this._idPet = obj[idPet];
    this._name = obj[namePet];
    this._dateOfBirth = obj[birthPet];
    this._gender = obj[genderPet];
    this._species = obj[speciePet];
    this._breed = obj[breedPet];
  }

  // ignore: non_constant_identifier_names
  set IdPet(value) => this._idPet = value;

  // ignore: non_constant_identifier_names
  int get IdPet => this._idPet;

  // ignore: non_constant_identifier_names
  set NamePet(value) => this._name = value;

  // ignore: non_constant_identifier_names
  String get NamePet => this._name;

  // ignore: non_constant_identifier_names
  set DateOfBirthPet(value) => this._dateOfBirth = value;

  // ignore: non_constant_identifier_names
  String get DateOfBirthPet => this._dateOfBirth;

  // ignore: non_constant_identifier_names
  set GenderPet(value) => this._gender = value;

  // ignore: non_constant_identifier_names
  String get GenderPet => this._gender;

  // ignore: non_constant_identifier_names
  set SpeciePet(value) => this._species = value;

  // ignore: non_constant_identifier_names
  String get SpeciePet => this._species;

  // ignore: non_constant_identifier_names
  set BreedPet(value) => this._breed = value;

  // ignore: non_constant_identifier_names
  String get BreedPet => this._breed;

  Map toMap() {
    Map<String, dynamic> map = {
      namePet: NamePet,
      birthPet: DateOfBirthPet,
      genderPet: GenderPet,
      speciePet: SpeciePet,
      breedPet: BreedPet,
    };
    if (this._idPet != null) map[idPet] = IdPet;

    return map;
  }

  String toString() {
    return "Id:$IdPet, Name:$NamePet, Date:$DateOfBirthPet, "
        "Gender:$GenderPet, Specie:$SpeciePet, Breed:$BreedPet";
  }
}

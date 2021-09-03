import 'dart:developer';

import 'package:followpet_alfa/database/sqlite/connection.dart';
import 'package:followpet_alfa/model/entities/pet_model.dart';
import 'package:followpet_alfa/model/interfaces/i_pet_dao.dart';
import 'package:followpet_alfa/utils/attributes_string.dart';
import 'package:sqflite/sqflite.dart';

class PetDaoImpl implements IPetDao {
  Database _db;

  @override
  Future<int> deleteById(int id) async {
    _db = await Connection.db;
    return await _db.delete(tablePet, where: '$idPet = ?', whereArgs: [id]);
    //qual valor inteiro ele retorna se a tupla for deletada?
  }

  @override
  Future<List> findAll() async {
    _db = await Connection.db;

    List listMap = await _db.rawQuery("SELECT * FROM $tablePet");

    List<PetModel> listPets = [];
    for (Map m in listMap) {
      listPets.add(PetModel.fromMap(m));
    }
    return listPets;
  }

  @override
  Future<PetModel> findById(int id) async {
    /// Esse metodo tem o objetivo de recupera um pet salvo
    /// no bando de dados, no formato da class pet.
    _db = await Connection.db;
    List<Map> maps = await _db.query(tablePet,
        columns: [
          idPet,
          namePet,
          birthPet,
          genderPet,
          speciePet,
          breedPet,
        ],
        where: '$idPet = ?',
        whereArgs: [id]);
    if (maps.length > 0) return PetModel.fromMap(maps.first);

    return null;
  }

  @override
  Future<int> insert(PetModel pet) async {
    _db = await Connection.db;
    try {
      pet.IdPet = await _db.insert(tablePet, pet.toMap());
      return pet.IdPet;
    } catch (e) {
      log('erro ao salvar: $e', name: "banco de dados");
      return 0;
    }
  }

  @override
  Future<int> totalRecord() async {
    _db = await Connection.db;
    return Sqflite.firstIntValue(
        await _db.rawQuery("SELECT COUNT(*) FROM $tablePet"));
  }

  @override
  Future<int> update(PetModel pet) async {
    _db = await Connection.db;

    return await _db.update(tablePet, pet.toMap(),
        where: '$idPet = ?', whereArgs: [pet.IdPet]);
  }
}

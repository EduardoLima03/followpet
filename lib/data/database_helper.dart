import 'dart:developer';

import 'package:followpet_alfa/model/pet_model.dart';
import 'package:followpet_alfa/utils/attributes_string.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  Database _db; //meu banco de dados

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'followpetalfa.db');

    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS $tablePet ($idPet INTEGER PRIMARY KEY AUTOINCREMENT, "
              "$namePet TEXT NOT NULL, $birthPet TEXT NOT NULL, "
              "$genderPet TEXT NOT NULL, $speciePet TEXT NOT NULL, "
              "$breedPet TEXT NOT NULL)");
    });
  }

  Future close() async {
    Database dbPet = await db;
    dbPet.close();
  }

  Future<int> delete(int id) async {
    Database dbPet = await db;
    return await dbPet.delete(tablePet, where: '$idPet = ?', whereArgs: [id]);
    //qual valor inteiro ele retorna se a tupla for deletada?
  }

  Future<int> update(PetModel pet) async {
    Database dbPet = await db;
    return await dbPet.update(tablePet, pet.toMap(),
        where: '$idPet = ?', whereArgs: [pet.IdPet]);
  }

  /// Esse metodo tem o objetivo de recupera um pet salvo
  /// no bando de dados, no formato da class pet.
  Future<PetModel> getPet(int id) async {
    Database dbPet = await db;
    List<Map> maps = await dbPet.query(tablePet,
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

  Future<List> getallPet() async {
    Database dbPet = await db;
    List listMap = await dbPet.rawQuery("SELECT * FROM $tablePet");

    List<PetModel> listPets = [];
    for(Map m in listMap){
      listPets.add(PetModel.fromMap(m));
    }
    return listPets;
  }

  Future<int> getNumber() async{
    Database dbPet = await db;
    return Sqflite.firstIntValue(await dbPet.rawQuery("SELECT COUNT(*) FROM $tablePet"));
  }

  Future<int> insert(PetModel pet) async {
    try {
      Database dbPet = await db;
      pet.IdPet = await dbPet.insert(tablePet, pet.toMap());
      return pet.IdPet;
    } catch (e) {
      log('erro ao salvar: $e', name: "banco de dados");
      return 0;
    }
  }
}

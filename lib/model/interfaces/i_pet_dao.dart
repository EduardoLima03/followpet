import 'package:followpet_alfa/model/entities/pet_model.dart';

abstract class IPetDao {
  Future<int> insert(PetModel obj);
  Future<int> update(PetModel obj);
  Future<int> deleteById(int id);
  Future<PetModel> findById(int id);
  Future<List> findAll();
  Future<int> totalRecord();
}

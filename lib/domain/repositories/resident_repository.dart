import 'package:resident_module/domain/entities/resident.dart';

abstract class ResidentRepository {
  Future<List<Resident>> getAll();
  Future<Resident?> getById(String id);
  Future<Resident?> getByPhone(String phoneNumber);
  Future<Resident?> getByEmail(String email);
  Future<void> save(Resident resident);
  Future<void> update(Resident resident);
  Future<void> delete(String id);
}

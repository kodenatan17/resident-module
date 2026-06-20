import 'package:resident_module/domain/entities/resident.dart';
import 'package:resident_module/domain/repositories/resident_repository.dart';

class ResidentRepositoryImpl implements ResidentRepository {
  final _residents = <String, Resident>{};
  final _phoneIndex = <String, String>{};
  final _emailIndex = <String, String>{};

  @override
  Future<List<Resident>> getAll() async {
    return _residents.values.toList(growable: false);
  }

  @override
  Future<Resident?> getById(String id) async {
    return _residents[id];
  }

  @override
  Future<Resident?> getByPhone(String phoneNumber) async {
    final id = _phoneIndex[phoneNumber];
    if (id == null) return null;
    return _residents[id];
  }

  @override
  Future<Resident?> getByEmail(String email) async {
    final id = _emailIndex[email];
    if (id == null) return null;
    return _residents[id];
  }

  @override
  Future<void> save(Resident resident) async {
    _residents[resident.id] = resident;
    _phoneIndex[resident.phoneNumber] = resident.id;
    _emailIndex[resident.email] = resident.id;
  }

  @override
  Future<void> update(Resident resident) async {
    final old = _residents[resident.id];
    if (old != null) {
      if (old.phoneNumber != resident.phoneNumber) {
        _phoneIndex.remove(old.phoneNumber);
        _phoneIndex[resident.phoneNumber] = resident.id;
      }
      if (old.email != resident.email) {
        _emailIndex.remove(old.email);
        _emailIndex[resident.email] = resident.id;
      }
    }
    _residents[resident.id] = resident;
  }

  @override
  Future<void> delete(String id) async {
    final resident = _residents.remove(id);
    if (resident != null) {
      _phoneIndex.remove(resident.phoneNumber);
      _emailIndex.remove(resident.email);
    }
  }
}

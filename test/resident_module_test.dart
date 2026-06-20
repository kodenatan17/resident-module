import 'package:flutter_test/flutter_test.dart';
import 'package:resident_module/application/repositories/resident_repository_impl.dart';
import 'package:resident_module/resident_module.dart';

void main() {
  group('Resident Repository', () {
    late ResidentRepository repository;

    setUp(() {
      repository = ResidentRepositoryImpl();
    });

    test('should save and retrieve resident by phone', () async {
      final now = DateTime.now();
      final resident = Resident(
        id: '1',
        name: 'John Doe',
        phoneNumber: '08123456789',
        email: 'john@example.com',
        createdAt: now,
        updatedAt: now,
      );

      await repository.save(resident);

      final result = await repository.getByPhone('08123456789');

      expect(result, isNotNull);
      expect(result?.id, '1');
      expect(result?.phoneNumber, '08123456789');
    });

    test('should save and retrieve resident by email', () async {
      final now = DateTime.now();
      final resident = Resident(
        id: '2',
        name: 'Jane Doe',
        phoneNumber: '08987654321',
        email: 'jane@example.com',
        createdAt: now,
        updatedAt: now,
      );

      await repository.save(resident);

      final result = await repository.getByEmail('jane@example.com');

      expect(result, isNotNull);
      expect(result?.id, '2');
      expect(result?.email, 'jane@example.com');
    });
  });
}

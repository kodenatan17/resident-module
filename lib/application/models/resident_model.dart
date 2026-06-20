import 'package:resident_module/domain/entities/resident.dart';

class ResidentModel extends Resident {
  const ResidentModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.email,
    super.address,
    super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ResidentModel.fromJson(Map<String, dynamic> json) {
    return ResidentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      address: json['address'] as String?,
      status: ResidentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ResidentStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'address': address,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ResidentModel.fromEntity(Resident resident) {
    return ResidentModel(
      id: resident.id,
      name: resident.name,
      phoneNumber: resident.phoneNumber,
      email: resident.email,
      address: resident.address,
      status: resident.status,
      createdAt: resident.createdAt,
      updatedAt: resident.updatedAt,
    );
  }
}

enum ResidentStatus { active, inactive, pending }

class Resident {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String? address;
  final ResidentStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Resident({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.address,
    this.status = ResidentStatus.pending,
    required this.createdAt,
    required this.updatedAt,
  });

  Resident copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? address,
    ResidentStatus? status,
    DateTime? updatedAt,
  }) {
    return Resident(
      id: id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

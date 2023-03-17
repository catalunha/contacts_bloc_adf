import 'dart:convert';

class ContactModel {
  final int? id;
  final String? name;
  final String email;
  ContactModel({
    this.id,
    this.name,
    required this.email,
  });

  ContactModel copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    result.addAll({'email': email});

    return result;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() => 'ContactModel(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactModel &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}

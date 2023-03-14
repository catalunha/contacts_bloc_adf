enum ContactEditStateStatus { initial, loading, success, error }

class ContactEditState {
  final ContactEditStateStatus status;
  final String? error;
  final String name;
  final String email;

  ContactEditState({
    this.status = ContactEditStateStatus.initial,
    this.error = '',
    required this.name,
    required this.email,
  });

  ContactEditState copyWith({
    ContactEditStateStatus? status,
    String? error,
    String? name,
    String? email,
  }) {
    return ContactEditState(
      status: status ?? this.status,
      error: error ?? this.error,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'ContactEditState(status: $status, error: $error, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactEditState &&
        other.status == status &&
        other.error == error &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode {
    return status.hashCode ^ error.hashCode ^ name.hashCode ^ email.hashCode;
  }
}

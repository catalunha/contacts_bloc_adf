enum ContactAddStateStatus { initial, loading, success, error }

class ContactAddState {
  final ContactAddStateStatus status;
  final String? error;
  final String name;
  final String email;

  ContactAddState({
    this.status = ContactAddStateStatus.initial,
    this.error = '',
    required this.name,
    required this.email,
  });

  ContactAddState copyWith({
    ContactAddStateStatus? status,
    String? error,
    String? name,
    String? email,
  }) {
    return ContactAddState(
      status: status ?? this.status,
      error: error ?? this.error,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'ContactAddState(status: $status, error: $error, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactAddState &&
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

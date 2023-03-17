import 'package:contacts_bloc_adf/contacts/models/contact_model.dart';

enum ContactAddEditStateStatus { initial, loading, success, error }

class ContactAddEditState {
  final ContactAddEditStateStatus status;
  final String? error;
  final ContactModel? contactInitial;
  final String? name;
  final String email;

  bool get isNewContact => contactInitial == null;
  ContactAddEditState({
    required this.status,
    this.error,
    this.contactInitial,
    this.name,
    required this.email,
  });
  ContactAddEditState.initial({
    required this.contactInitial,
  })  : status = ContactAddEditStateStatus.initial,
        error = null,
        name = null,
        email = '';

  ContactAddEditState copyWith({
    ContactAddEditStateStatus? status,
    String? error,
    ContactModel? contactInitial,
    String? name,
    String? email,
  }) {
    return ContactAddEditState(
      status: status ?? this.status,
      error: error ?? this.error,
      contactInitial: contactInitial ?? this.contactInitial,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'ContactAddEditState(status: $status, error: $error, contactInitial: $contactInitial, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactAddEditState &&
        other.status == status &&
        other.error == error &&
        other.contactInitial == contactInitial &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        error.hashCode ^
        contactInitial.hashCode ^
        name.hashCode ^
        email.hashCode;
  }
}

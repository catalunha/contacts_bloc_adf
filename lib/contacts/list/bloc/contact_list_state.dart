import 'package:flutter/foundation.dart';

import '../../models/contact_model.dart';

enum ContactListStateStatus { initial, loading, success, error }

class ContactListState {
  final ContactListStateStatus status;
  final String? error;
  final List<ContactModel> contacts;
  ContactListState({
    this.status = ContactListStateStatus.initial,
    this.error,
    this.contacts = const [],
  });

  ContactListState copyWith({
    ContactListStateStatus? status,
    String? error,
    List<ContactModel>? contacts,
  }) {
    return ContactListState(
      status: status ?? this.status,
      error: error ?? this.error,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  String toString() =>
      'ContactListState(status: $status, error: $error, contacts: $contacts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactListState &&
        other.status == status &&
        other.error == error &&
        listEquals(other.contacts, contacts);
  }

  @override
  int get hashCode => status.hashCode ^ error.hashCode ^ contacts.hashCode;
}

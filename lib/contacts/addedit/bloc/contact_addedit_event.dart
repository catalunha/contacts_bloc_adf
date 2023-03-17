abstract class ContactAddEditEvent {}

class ContactAddEditEventSubmit extends ContactAddEditEvent {
  final String name;
  final String email;

  ContactAddEditEventSubmit({
    required this.name,
    required this.email,
  });
}

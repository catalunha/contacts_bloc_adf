abstract class ContactEditEvent {}

class ContactEditEventSubmit extends ContactEditEvent {
  final int? id;
  final String name;
  final String email;

  ContactEditEventSubmit({
    this.id,
    required this.name,
    required this.email,
  });
}

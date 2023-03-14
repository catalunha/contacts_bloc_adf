abstract class ContactAddEvent {}

class ContactAddEventSubmit extends ContactAddEvent {
  final String name;
  final String email;

  ContactAddEventSubmit({required this.name, required this.email});
}

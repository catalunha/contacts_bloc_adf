abstract class ContactListEvent {}

class ContactListEventFindAll extends ContactListEvent {}

class ContactListEventDelete extends ContactListEvent {
  final int id;

  ContactListEventDelete({required this.id});
}

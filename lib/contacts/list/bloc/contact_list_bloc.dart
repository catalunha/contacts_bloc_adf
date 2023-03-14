import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../repositories/contact_repository.dart';
import 'contact_list_event.dart';
import 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactRepository _contactRepository;
  ContactListBloc({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(ContactListState()) {
    on<ContactListEventFindAll>(_onContactListEventFindAll);
    on<ContactListEventDelete>(_onContactListEventDelete);
  }
  FutureOr<void> _onContactListEventDelete(
      ContactListEventDelete event, Emitter<ContactListState> emit) async {
    try {
      print('_onContactListEventDelete');
      emit(
          state.copyWith(contacts: [], status: ContactListStateStatus.loading));
      await _contactRepository.delete(event.id);
      var contactsNew = await _contactRepository.findAll();
      // throw Exception();
      emit(state.copyWith(
          contacts: contactsNew, status: ContactListStateStatus.success));
      // throw Exception();
    } catch (e) {
      emit(state.copyWith(
          contacts: [],
          status: ContactListStateStatus.error,
          error: 'Erro no findAll'));
    }
  }

  FutureOr<void> _onContactListEventFindAll(
      ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      print('_onContactListEventFindAll');
      emit(state.copyWith(status: ContactListStateStatus.loading));
      var contactsNew = await _contactRepository.findAll();
      // throw Exception();
      emit(state.copyWith(
          contacts: contactsNew, status: ContactListStateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          contacts: [],
          status: ContactListStateStatus.error,
          error: 'Erro no findAll'));
    }
  }
}

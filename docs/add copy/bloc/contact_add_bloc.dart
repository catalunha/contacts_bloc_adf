import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_bloc_adf/contacts/models/contact_model.dart';
import 'package:contacts_bloc_adf/contacts/repositories/contact_repository.dart';

import 'contact_add_event.dart';
import 'contact_add_state.dart';

class ContactAddBloc extends Bloc<ContactAddEvent, ContactAddState> {
  final ContactRepository _contactRepository;
  ContactAddBloc({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(ContactAddState(name: '', email: '')) {
    on<ContactAddEventSubmit>(_onContactAddEventSubmit);
  }
  FutureOr<void> _onContactAddEventSubmit(
      ContactAddEventSubmit event, Emitter<ContactAddState> emit) async {
    try {
      emit(state.copyWith(status: ContactAddStateStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      var contact = ContactModel(name: event.name, email: event.email);
      // throw Exception();
      await _contactRepository.create(contact);
      emit(state.copyWith(status: ContactAddStateStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
            status: ContactAddStateStatus.error, error: 'Erro ao add item'),
      );
    }
  }
}

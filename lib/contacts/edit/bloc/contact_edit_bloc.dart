import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/contact_model.dart';
import '../../repositories/contact_repository.dart';
import 'contact_edit_event.dart';
import 'contact_edit_state.dart';

class ContactEditBloc extends Bloc<ContactEditEvent, ContactEditState> {
  final ContactRepository _contactRepository;
  ContactEditBloc({required ContactRepository contactRepository})
      : _contactRepository = contactRepository,
        super(ContactEditState(name: '', email: '')) {
    on<ContactEditEventSubmit>(_onContactEditEventSubmit);
  }
  FutureOr<void> _onContactEditEventSubmit(
      ContactEditEventSubmit event, Emitter<ContactEditState> emit) async {
    try {
      emit(state.copyWith(status: ContactEditStateStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      var contact =
          ContactModel(id: event.id, name: event.name, email: event.email);
      // throw Exception();
      await _contactRepository.update(contact);
      emit(state.copyWith(status: ContactEditStateStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
            status: ContactEditStateStatus.error, error: 'Erro ao Edit item'),
      );
    }
  }
}

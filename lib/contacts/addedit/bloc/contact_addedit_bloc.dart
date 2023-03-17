import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/contact_model.dart';
import '../../repositories/contact_repository.dart';
import 'contact_addedit_event.dart';
import 'contact_addedit_state.dart';

class ContactAddEditBloc
    extends Bloc<ContactAddEditEvent, ContactAddEditState> {
  final ContactRepository _contactRepository;
  ContactAddEditBloc(
      {required ContactRepository contactRepository,
      required ContactModel? contactInitial})
      : _contactRepository = contactRepository,
        super(ContactAddEditState.initial(contactInitial: contactInitial)) {
    on<ContactAddEditEventSubmit>(_onContactAddEditEventSubmit);
  }
  FutureOr<void> _onContactAddEditEventSubmit(ContactAddEditEventSubmit event,
      Emitter<ContactAddEditState> emit) async {
    try {
      emit(state.copyWith(status: ContactAddEditStateStatus.loading));
      await Future.delayed(const Duration(seconds: 2));

      var contact = (state.contactInitial ?? ContactModel(email: ''))
          .copyWith(name: event.name, email: event.email);

      // throw Exception();
      if (state.contactInitial == null) {
        await _contactRepository.create(contact);
      } else {
        await _contactRepository.update(contact);
      }
      emit(state.copyWith(status: ContactAddEditStateStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
            status: ContactAddEditStateStatus.error,
            error: 'Erro ao AddEdit item'),
      );
    }
  }
}

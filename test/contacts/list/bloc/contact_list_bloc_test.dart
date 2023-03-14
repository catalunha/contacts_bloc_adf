import 'package:bloc_test/bloc_test.dart';
import 'package:contacts_bloc_adf/contacts/list/bloc/contact_list_bloc.dart';
import 'package:contacts_bloc_adf/contacts/list/bloc/contact_list_event.dart';
import 'package:contacts_bloc_adf/contacts/list/bloc/contact_list_state.dart';
import 'package:contacts_bloc_adf/contacts/models/contact_model.dart';
import 'package:contacts_bloc_adf/contacts/repositories/contact_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactRepository extends Mock implements ContactRepository {}

void main() {
// declaração
  late MockContactRepository mockContactRepository;
  late ContactListBloc contactListBloc;
  late List<ContactModel> contactModelList;
// preparação
  setUp(() {
    mockContactRepository = MockContactRepository();
    contactListBloc = ContactListBloc(contactRepository: mockContactRepository);
    contactModelList = [
      ContactModel(name: 'a', email: 'b'),
      ContactModel(name: 'c', email: 'd'),
    ];
  });

// execução
  blocTest<ContactListBloc, ContactListState>('Buscar contatos',
      build: () => contactListBloc,
      act: (bloc) => bloc.add(ContactListEventFindAll()),
      setUp: () {
        when(() => mockContactRepository.findAll())
            .thenAnswer((_) async => contactModelList);
      },
      expect: () => [
            ContactListState(
              status: ContactListStateStatus.loading,
              error: null,
              contacts: [],
            ),
            ContactListState(
              status: ContactListStateStatus.success,
              error: null,
              contacts: [
                ContactModel(id: null, name: 'a', email: 'b'),
                ContactModel(id: null, name: 'c', email: 'd')
              ],
            )
          ]);
}

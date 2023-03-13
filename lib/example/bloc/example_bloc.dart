import 'package:bloc/bloc.dart';
import 'package:contacts_bloc_adf/example/repository/example_repository.dart';

import 'example_event.dart';
import 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleRepository _exampleRepository;
  ExampleBloc({required ExampleRepository exampleRepository})
      : _exampleRepository = exampleRepository,
        super(ExampleStateInitial()) {
    on<ExampleEventFindNames>(onExampleEventFindNames);
    on<ExampleEventRemoveName>(onExampleEventRemoveName);
  }

  Future<void> onExampleEventFindNames(
      ExampleEventFindNames event, Emitter<ExampleState> emit) async {
    List<String> namesList = await _exampleRepository.getNames();
    emit(ExampleStateData(names: namesList));
  }

  Future<void> onExampleEventRemoveName(
      ExampleEventRemoveName event, Emitter<ExampleState> emit) async {
    final stateLocal = state;
    if (stateLocal is ExampleStateData) {
      final namesNew = [...stateLocal.names];
      // names.remove(event.name);
      namesNew.retainWhere((e) => e != event.name);
      emit(stateLocal.copyWith(names: namesNew));
    }
  }
}

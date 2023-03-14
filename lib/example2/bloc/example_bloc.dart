import 'package:bloc/bloc.dart';
import '../repository/example_repository.dart';
import 'example_event.dart';
import 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final ExampleRepository _exampleRepository;
  ExampleBloc({required ExampleRepository exampleRepository})
      : _exampleRepository = exampleRepository,
        super(const ExampleState(status: ExampleStateStatus.initial)) {
    on<ExampleEventFindNames>(onExampleEventFindNames);
    on<ExampleEventRemoveName>(onExampleEventRemoveName);
  }

  Future<void> onExampleEventFindNames(
      ExampleEventFindNames event, Emitter<ExampleState> emit) async {
    List<String> namesList = await _exampleRepository.getNames();
    emit(state.copyWith(names: namesList, status: ExampleStateStatus.data));
  }

  Future<void> onExampleEventRemoveName(
      ExampleEventRemoveName event, Emitter<ExampleState> emit) async {
    final namesNew = [...state.names];
    namesNew.retainWhere((e) => e != event.name);
    emit(state.copyWith(names: namesNew));
  }
}

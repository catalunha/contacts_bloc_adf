abstract class ExampleEvent {}

class ExampleEventAddName extends ExampleEvent {}

class ExampleEventFindNames extends ExampleEvent {}

class ExampleEventRemoveName extends ExampleEvent {
  final String name;

  ExampleEventRemoveName(this.name);
}

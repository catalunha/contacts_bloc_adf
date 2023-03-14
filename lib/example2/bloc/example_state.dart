import 'package:flutter/foundation.dart';

enum ExampleStateStatus { initial, data }

class ExampleState {
  final ExampleStateStatus status;
  final List<String> names;

  const ExampleState(
      {this.names = const [], this.status = ExampleStateStatus.initial});

  ExampleState copyWith({
    ExampleStateStatus? status,
    List<String>? names,
  }) {
    return ExampleState(
      status: status ?? this.status,
      names: names ?? this.names,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExampleState &&
        other.status == status &&
        listEquals(other.names, names);
  }

  @override
  int get hashCode => status.hashCode ^ names.hashCode;
}

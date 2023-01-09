// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

@immutable
abstract class CounterEvent {
  T map<T>({
    required T Function(Increment event) increment,
    required T Function(Decrement event) decrement,
  });
}

class Increment extends CounterEvent {
  @override
  T map<T>({
    required T Function(Increment event) increment,
    required T Function(Decrement event) decrement,
  }) =>
      increment(this);
}

class Decrement extends CounterEvent {
  @override
  T map<T>({
    required T Function(Increment event) increment,
    required T Function(Decrement event) decrement,
  }) =>
      decrement(this);
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>(
      (event, emit) => _increment(event, emit),
      transformer: sequential(),
    );
    on<Decrement>(
      (event, emit) => _decrement(event, emit),
      transformer: concurrent(),
    );
  }

  Future<void> _increment(Increment event, Emitter<int> emit) async {
    for (var i = 0; i < 3; ++i) {
      emit(state + 1);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  Future<void> _decrement(Decrement event, Emitter<int> emit) async {
    for (var i = 0; i < 3; ++i) {
      emit(state - 1);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }
}

void main([List<String>? arguments]) {
  final bloc = CounterBloc();
  bloc.stream.listen(print);
  bloc //
        ..add(Increment())
        ..add(Increment())
      // ..add(Decrement())
      // ..add(Decrement())
      //
      ;
}

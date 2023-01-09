// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

@immutable
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => _increment(event, emit));
    on<Decrement>((event, emit) => _decrement(event, emit));
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
        // ..add(Increment())
        ..add(Decrement())
      // ..add(Decrement())
      //
      ;
}

import 'package:bill_management_app/amount_repository.dart';
import 'package:bloc/bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent , CounterState> {
  final AmountRepository amountRepository = AmountRepository();


  CounterBloc() : super( CounterState()) {
    on<Addition>(_addition);
    // on<Substraction>(_substraction);
    // on<Multiplication>(_multiplication);
    // on<Division>(_division);
  }

  void _addition(Addition event, Emitter<CounterState> emit) {
    int ans = amountRepository.add(no1: event.no1);
    emit(state.copyWith(ans: ans));
  }

  // void _substraction(Substraction event, Emitter<CounterState> emit) {
  //   int ans = calcRepo.subtract(no1: event.no1, no2: event.no2);
  //   emit(state.copyWith(ans: ans ));
  // }
  // void _multiplication(Multiplication event, Emitter<CounterState> emit) {
  //   int ans = calcRepo.multiply(no1: event.no1, no2: event.no2);
  //   emit(state.copyWith(ans: ans));
  // }
  //
  // void _division(Division event, Emitter<CounterState> emit) {
  //   int ans = calcRepo.divide(no1: event.no1, no2: event.no2);
  //   emit(state.copyWith(ans: ans));
  // }
}
import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  CounterEvent();
  @override
  List<Object> get props => [];
}

class Addition extends CounterEvent {
  final int no1;
  Addition({required this.no1});
}
// class Substraction extends CounterEvent {
//   final int no1;
//   final int no2;
//   Substraction({required this.no1, required this.no2});
// }
// class Multiplication extends CounterEvent {
//   final int no1;
//   final int no2;
//   Multiplication({required this.no1, required this.no2});
// }
// class Division extends CounterEvent {
//   final int no1;
//   final int no2;
//   Division({required this.no1, required this.no2});
// }
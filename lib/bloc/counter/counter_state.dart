import 'package:equatable/equatable.dart';

class CounterState extends Equatable {

  final int ans;


  const CounterState({
    this.ans=0
   });

  CounterState copyWith({int? ans}){
    return CounterState(

      ans: ans ?? this.ans
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [ans];

}
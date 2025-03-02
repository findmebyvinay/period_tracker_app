import 'package:equatable/equatable.dart';
import 'package:period_tracker_app/model/cycle_prediction.dart';
import 'package:period_tracker_app/model/user_data.dart';

abstract class PeriodState extends Equatable {
  List<Object> get props=>[];
}

class PeriodInitial extends PeriodState{

}

class PeriodLoading extends PeriodState{

}
class PeriodLoaded extends PeriodState{
  final UserData data;
  final CyclePrediction cycle;

  PeriodLoaded(this.data,this.cycle);

  List<Object> get props=>[data,cycle];
}
class PeriodError extends PeriodState{
  String message;
  PeriodError(this.message);

  List<Object> get props=>[message];
}
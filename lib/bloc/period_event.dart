import 'package:equatable/equatable.dart';
import 'package:period_tracker_app/model/user_data.dart';

abstract class PeriodEvent extends Equatable{
  List<Object> get props=>[];

}

class SubmitUserData extends PeriodEvent{
  final UserData data;
  SubmitUserData(this.data);

  List<Object> get props=>[data];
}
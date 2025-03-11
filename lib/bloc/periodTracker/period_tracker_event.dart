import 'package:equatable/equatable.dart';
import 'package:period_tracker_app/model/period_data.dart';

abstract class PeriodTrackerEvent extends Equatable{
  List<Object> get props=>[];
}

class LoadPeriodData extends PeriodTrackerEvent{

}

class AddPeriodData extends PeriodTrackerEvent{
  final DateTime startDate;
  final  int periodDuration;
  final int cycleDuration;
  final List<SymptomLog> symptom;
  final Map<String,dynamic> healthMetrics;

  AddPeriodData({
    required this.startDate,
    required this.periodDuration,
    required this.cycleDuration,
    required this.symptom,
    required this.healthMetrics
  });

  List<Object> get props=>[startDate,periodDuration,cycleDuration,symptom,healthMetrics];
}

class AddSymptom extends PeriodTrackerEvent{
  final String periodId;
  final SymptomLog symptom;
  AddSymptom({
    required this.periodId,
    required this.symptom
  });

  List<Object> get props=> [periodId,symptom];
}

class PredictNextPeriod extends PeriodTrackerEvent{

}

class PredictOvulation extends PeriodTrackerEvent{}
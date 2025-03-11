import 'package:equatable/equatable.dart';
import 'package:period_tracker_app/model/period_data.dart';

abstract class PeriodTrackerState extends Equatable{

  List<Object> get props=>[];
}

class PeriodTrackerInitial extends PeriodTrackerState{

}
class PeriodTrackerLoading extends PeriodTrackerState{

}
class PeriodTrackerLoaded extends PeriodTrackerState{
  final List<PeriodData> periodData;
  final Map<DateTime,List<PeriodData>> calendarData;
  final DateTime? nextPeriodDate;
  final DateTime? ovulationDate;
  final DateTime?fertileWindowStart;
  final DateTime? fertileWindowEnd;

  PeriodTrackerLoaded({
  required this.periodData,
  required this.calendarData,
  this.nextPeriodDate,
  this.ovulationDate,
  this.fertileWindowStart,
  this.fertileWindowEnd
  });

  List<Object> get props=> [

    periodData,
    calendarData,
    nextPeriodDate!,
    ovulationDate!,
    fertileWindowStart!,
    fertileWindowEnd!

  ];
}

class PeriodTrackerError extends PeriodTrackerState{
  final String message;
  PeriodTrackerError(this.message);
  List<Object> get props=> [message];
}
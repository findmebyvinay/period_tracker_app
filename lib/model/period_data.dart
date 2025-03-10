import 'package:hive/hive.dart';
 part 'period_data.g.dart';

@HiveType(typeId: 1)
class PeriodData {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime cycleStartDate;
  
  @HiveField(2)
  final int periodDuration;

  @HiveField(3)
  final int cycleDuration;

  @HiveField(4)
  final List<SymptomLog> symptoms;

  @HiveField(5)
  final Map<String,dynamic> healthMetrics;

  PeriodData({
    required this.id,
    required this.cycleStartDate,
    required this.cycleDuration,
    required this.periodDuration,
    this.symptoms=const [],
    this.healthMetrics=const {}
  });

  DateTime get periodEndDate=> cycleStartDate.add(Duration(days: periodDuration));

  DateTime get ovulationDate=> cycleStartDate.add(Duration(days:( cycleDuration/2).floor()-14));

  DateTime get fertileWindowStart => ovulationDate.subtract(const Duration(days: 5));

  DateTime get fertileWindowEnd => ovulationDate.add(const  Duration(days: 1));

  DateTime get nextPeriodDate=> cycleStartDate.add(Duration(days: cycleDuration));

}

@HiveType(typeId: 2)
class SymptomLog {

  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String symptomType;

  @HiveField(2)
  final int intensity;
  
  @HiveField(3)
  final String? notes;

  SymptomLog({
    required this.date,
    required this.symptomType,
    required this.intensity,
    this.notes
  });

}
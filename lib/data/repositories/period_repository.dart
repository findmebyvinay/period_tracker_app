import 'dart:ffi';

import 'package:period_tracker_app/data/datasource/local_data_source.dart';
import 'package:period_tracker_app/model/period_data.dart';
import 'package:uuid/uuid.dart';

class PeriodRepository {
  final LocalDataSource _localDataSource;
  final Uuid _uuid=const Uuid();

  PeriodRepository(this._localDataSource);

  Future<void> logPeriodStart({
    required DateTime startDate,
    required int periodDuration,
    required int cycleDuration,
    List<SymptomLog> symptoms=const[],
    Map<String,dynamic> healthMetrics=const {}
  })async{
    final periodData = PeriodData(
      id:_uuid.v4(),
      cycleStartDate: startDate,
      cycleDuration: cycleDuration,
      periodDuration: periodDuration);
 
      await _localDataSource.savePeriodData(periodData);
  }

  Future<List<PeriodData>> getAllPeriodData()async{

    return _localDataSource.getAllPeriodData();
  }

Future<PeriodData> _getPeriodById(String id)async{
  final allData = await _localDataSource.getAllPeriodData();
  return allData.firstWhere((data)=>data.id==id);
}
  Future<void> addSymptom(String periodId,SymptomLog symptom)async{
    final periodData = await _getPeriodById(periodId);
    final updatedSymptoms = List<SymptomLog>.from(periodData.symptoms..add(symptom));

    final updatedPeriodData = PeriodData(
      id: periodData.id,
      cycleStartDate: periodData.cycleStartDate,
      cycleDuration: periodData.cycleDuration,
      periodDuration: periodData.periodDuration,
      symptoms: updatedSymptoms,
      healthMetrics: periodData.healthMetrics);

     await _localDataSource.savePeriodData(updatedPeriodData);
    }

    Future<Map<DateTime,List<PeriodData>>> getPeriodCalendarData()async{
      final allData = await _localDataSource.getAllPeriodData();

      final calendarData= <DateTime,List<PeriodData>>{};
      for(final data in allData){
        final startDate = DateTime(data.cycleStartDate.year,
        data.cycleStartDate.month,data.cycleStartDate.day,);
        for(var i=0; i<data.periodDuration;i++){
          final day = startDate.add(Duration(days: i));

          calendarData[day]=[...calendarData[day]??[]];
        }
      }
      return calendarData;
    }

    Future<DateTime?> predictNextPeriod()async{
      final allData= await _localDataSource.getAllPeriodData();
      if(allData.isEmpty) return null;

      allData.sort((a,b)=> b.cycleStartDate.compareTo(a.cycleStartDate));

      final latestPeriod=allData.first;

      return latestPeriod.nextPeriodDate;
    }

    Future<DateTime?> predictOvulation()async{
      final allData= await _localDataSource.getAllPeriodData();
      if(allData.isEmpty) return null;
      allData.sort((a,b)=> b.cycleStartDate.compareTo(a.cycleStartDate));
      final latestPeriod=allData.first;

      return latestPeriod.ovulationDate;
    }
}
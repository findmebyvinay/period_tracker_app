import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker_app/bloc/periodTracker/period_tracker_state.dart';
import 'package:period_tracker_app/data/repositories/period_repository.dart';

import 'period_tracker_event.dart';

class PeriodTrackerBloc extends Bloc<PeriodTrackerEvent,PeriodTrackerState>{
  final PeriodRepository _periodRepo;
  PeriodTrackerBloc(this._periodRepo):super(PeriodTrackerInitial()){

    on<LoadPeriodData> (_onLoadPeriodData);
    on<AddPeriodData> (_onAddPeriodData);
    on<AddSymptom> (_onAddSymptom);
    on<PredictNextPeriod> (_onPredictNextPeriod);
    on<PredictOvulation> (_onPredictOvulation);
  }

  Future<void> _onLoadPeriodData(LoadPeriodData event,Emitter<PeriodTrackerState> emit)async{
    emit(PeriodTrackerLoading());
    try{
       final periodData= await _periodRepo.getAllPeriodData();
       final calendarData= await _periodRepo.getPeriodCalendarData();
       final nextPeriodDate= await _periodRepo.predictNextPeriod();
       final ovulationDate= await _periodRepo.predictOvulation();

       DateTime? fertileWindowStart;
       DateTime? fertileWindowEnd;
      if(ovulationDate !=null){
        fertileWindowStart = ovulationDate.subtract(const Duration(days: 5));
        fertileWindowEnd= ovulationDate.add(const Duration(days: 1));
      }

      emit(PeriodTrackerLoaded(
        periodData: periodData,
        calendarData: calendarData,
        nextPeriodDate: nextPeriodDate,
        fertileWindowStart: fertileWindowStart,
        fertileWindowEnd: fertileWindowEnd));
    }
    catch(e){
      emit(PeriodTrackerError('Failed to load data: ${e.toString()}'));
    }
  }

  Future<void> _onAddPeriodData(AddPeriodData event,Emitter<PeriodTrackerState> emit)async{

    try{
      await _periodRepo.logPeriodStart(
        startDate:event.startDate,
        periodDuration:event.periodDuration,
        cycleDuration: event.cycleDuration,
        symptoms: event.symptom,
        healthMetrics: event.healthMetrics);
        
        add(LoadPeriodData());

    }
    catch(e){
      emit(PeriodTrackerError('Failed to load data:${e.toString()}'));
    }
  }

  Future<void> _onAddSymptom(AddSymptom event,Emitter<PeriodTrackerState> emit)async{
    try{
        await _periodRepo.addSymptom(
          event.periodId,
          event.symptom);
          add(LoadPeriodData());
    }
    catch(e){
      emit(PeriodTrackerError('Failed to load Data: ${e.toString()}'));
    }
  }

  Future<void> _onPredictNextPeriod(PredictNextPeriod event,Emitter<PeriodTrackerState> emit)async{
      if(state is PeriodTrackerLoaded){

        final currentState = state as PeriodTrackerLoaded;
        try{
            final nextPeriodDate = await _periodRepo.predictNextPeriod();

          emit(PeriodTrackerLoaded(
            periodData: currentState.periodData,
             calendarData: currentState.calendarData,
             nextPeriodDate: nextPeriodDate,
             
             ));
        }
        catch(e){
          emit(PeriodTrackerError('Error on predicting:${e.toString()}'));
        }
      }

  }

  Future<void> _onPredictOvulation(PredictOvulation event,Emitter<PeriodTrackerState> emit)async{
    
        if(state is PeriodTrackerLoaded){

          final currentState= state as PeriodTrackerLoaded;

          try{
            final nextOvulationDate= await _periodRepo.predictOvulation();
             DateTime? fertileWindowStart;
        DateTime? fertileWindowEnd;
        
        if (nextOvulationDate != null) {
          fertileWindowStart = nextOvulationDate.subtract(const Duration(days: 5));
          fertileWindowEnd = nextOvulationDate.add(const Duration(days: 1));
        }
            emit(PeriodTrackerLoaded(
              periodData:currentState.periodData,
              calendarData:currentState.calendarData,
              ovulationDate: nextOvulationDate,
              fertileWindowStart: fertileWindowStart,
              fertileWindowEnd: fertileWindowEnd));
          }
    catch(e){
      emit(PeriodTrackerError('Failed to load Prediction:${e.toString()}'));
    }
        }
    
  }

}
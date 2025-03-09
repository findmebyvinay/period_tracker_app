import 'package:bloc/bloc.dart';
import 'package:period_tracker_app/bloc/period_event.dart';
import 'package:period_tracker_app/bloc/period_state.dart';
import 'package:period_tracker_app/model/cycle_prediction.dart';
import 'package:period_tracker_app/model/user_data.dart';
import 'package:period_tracker_app/services/storage_service.dart';

class PeriodBloc  extends Bloc<PeriodEvent,PeriodState>{
  final StorageService _storageService;
  PeriodBloc(this._storageService):super(PeriodInitial()){
   
   on<SubmitUserData> (_onSubmitUserData);

  }
  void _onSubmitUserData(SubmitUserData event,Emitter<PeriodState> emit)async{
   emit(PeriodLoading());
   try{
        final userData= event.data;
      //  final data = await _storageService.getCycleData();
        final prediction=_calculateCycle(userData);
        
        emit(PeriodLoaded(userData, prediction));

   }
   catch(e){
    emit(PeriodError(e.toString()));
   }
  }
  CyclePrediction _calculateCycle(UserData data){
    final nextPeriodStart= data.lastPeriodStart.add(Duration(days: data.cycleLength));
    final ovulationDays= nextPeriodStart.subtract(Duration(days: 14));
    final fertileStart= ovulationDays.subtract(Duration(days: 5));
    final fertileEnd=ovulationDays.add(Duration(days: 2));

    return CyclePrediction(
      nextPeriodStart: nextPeriodStart,
       ovulationDays: ovulationDays,
        fertileStart: fertileStart,
         fertileEnd: fertileEnd);
  }
}
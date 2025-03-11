import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker_app/bloc/authentication/register_event.dart';
import 'package:period_tracker_app/bloc/authentication/register_state.dart';
import 'package:period_tracker_app/data/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  UserRepository _userRepo;
  RegisterBloc(this._userRepo):super(RegisterInital()){
    on<RegisterUser> (_onRegisterUser);
  }

  Future<void> _onRegisterUser(RegisterUser event,Emitter<RegisterState> emit)async{
    try{
        await _userRepo.saveUserProfile(event.userProfile);
        emit(RegisterLoaded(profile:event.userProfile));
    }
    catch(e){
      emit(RegisterError('Failed to register:${e.toString()}'));
    }
  }
}
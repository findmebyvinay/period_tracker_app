import 'package:equatable/equatable.dart';
import 'package:period_tracker_app/model/user_profile.dart';

abstract class RegisterState extends Equatable{
  List<Object> get props=>[];
}

class RegisterInital extends RegisterState{

}
class RegisterLoading extends RegisterState{

}
class RegisterLoaded extends RegisterState{
  UserProfile profile;
  RegisterLoaded({required this.profile});
  List<Object> get props=>[profile];
}

class RegisterError extends RegisterState{
  String message;
  RegisterError(this.message);

  List<Object> get props=>[message];
}
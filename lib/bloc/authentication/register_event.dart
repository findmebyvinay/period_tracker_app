import 'package:equatable/equatable.dart';
import 'package:period_tracker_app/model/user_profile.dart';

abstract class RegisterEvent extends Equatable{
  List<Object> get props=>[];
}

class RegisterUser extends RegisterEvent{
  UserProfile userProfile;
  RegisterUser({required this.userProfile});
}

import 'package:period_tracker_app/data/datasource/local_data_source.dart';
import 'package:period_tracker_app/model/user_profile.dart';

class UserRepository {

  final LocalDataSource _localDataSource;
  UserRepository(this._localDataSource);

  Future<void> saveUserProfile(UserProfile profile)async{
    await _localDataSource.saveUserProfile(profile);
  }

  UserProfile? getUserProfile(){
    return _localDataSource.getUserProfile();
  }

  bool hasUserProfile(){
    return _localDataSource.getUserProfile()!=null;
  }
}
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:period_tracker_app/model/period_data.dart';

import '../../model/user_profile.dart';

class LocalDataSource{
  static const userProfileBoxName= 'userProfileBox';
  static const periodDataBoxName= 'periodDataBox';


  static Future<void> init() async{

    final appDocumentDir= await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(PeriodDataAdapter());
    Hive.registerAdapter(SymptomLogAdapter());

    await Hive.openBox<UserProfile>(userProfileBoxName);
    await Hive.openBox<PeriodData>(periodDataBoxName);
  }

  //save user data
  Future<void> saveUserProfile(UserProfile profile)async{
    final box= Hive.box<UserProfile>(userProfileBoxName);
    await box.put('user_profile', profile);
  }

  UserProfile? getUserProfile(){
    final box= Hive.box<UserProfile>(userProfileBoxName);
    return box.get('user_profile');
  }

  Future<void> savePeriodData(PeriodData data)async{
    final box= Hive.box<PeriodData>(periodDataBoxName);
    await box.put(data.id, data);
  }

  Future<List<PeriodData>> getAllPeriodData()async{
    final box= Hive.box<PeriodData>(periodDataBoxName);
    return box.values.toList();
  }

  Future<void> deletePeriodData(String id)async{
      final box= Hive.box<PeriodData>(periodDataBoxName);
      await box.delete(id);
  }
}
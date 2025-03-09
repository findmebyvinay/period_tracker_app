import 'package:hive/hive.dart';
import 'package:period_tracker_app/model/user_data.dart';

class StorageService{
 final Box _cycleBox =Hive.box('cycleBox');

 Future<void> saveCycleData(UserData data)async{
  await _cycleBox.put('cycleData', data.toJson);
 }
 Future<UserData?> getCycleData()async{
  final data = _cycleBox.get('cycleData');
  return data !=null? UserData.fromJson(data):null;
 }
  
}
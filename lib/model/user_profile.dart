import 'package:hive/hive.dart';
part 'user_profile.g.dart';
@HiveType(typeId:0)
class UserProfile {

@HiveField(0)
final String id;
@HiveField(1)
final String name;
@HiveField(2)
final int age;
@HiveField(3)
final double height;
@HiveField(4)
final double weight;

UserProfile({
  required this.id,
  required this.name,
  required this.age,
  required this.height,
  required this.weight
});
}
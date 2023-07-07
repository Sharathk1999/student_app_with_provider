
import 'package:hive_flutter/hive_flutter.dart';
part 'studentModel.g.dart';

@HiveType(typeId: 1)
class StudentModel {


  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String mail;

  @HiveField(4)
  String? imgPath;
  
//id is used to get student created time as string to use as id.
  @HiveField(5)
  String id;


  StudentModel({
      required this.name,
      required this.age,
      required this.phone,
      required this.mail,
      required this.id,
      this.imgPath});
}

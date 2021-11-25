import 'package:hive/hive.dart';

part 'expire.g.dart';

@HiveType(typeId: 0)
class Expire extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime createdDate;

  @HiveField(2)
  int days;

  @HiveField(3)
  DateTime expiryDate;

  @HiveField(4)
  String date;
}
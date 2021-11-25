import 'package:hive/hive.dart';
import 'package:food_app/model/expire.dart';

class Boxes {
  static Box<Expire> getExpiration() =>
      Hive.box<Expire>('expiration');
}
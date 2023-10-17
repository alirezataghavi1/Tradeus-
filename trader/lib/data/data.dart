import 'package:hive_flutter/adapters.dart';
part  'data.g.dart';
DateTime now = DateTime.now();
DateTime date = DateTime(now.year, now.month, now.day);

@HiveType(typeId: 0)
class History extends HiveObject {
  int id = -1;
  @HiveField(0)
  String currencyName = '';
  @HiveField(1)
  var margin = '';
  @HiveField(2)
  var leverage = '';
  @HiveField(3)
  var openedPrice ='';
  @HiveField(4)
  var closedPrice ='';
  @HiveField(5)
  String openedDate ='';
  @HiveField(6)
  String closedDate ='';
  @HiveField(7)
  String description = '';
}

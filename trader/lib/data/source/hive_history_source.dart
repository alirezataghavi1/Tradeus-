

import 'package:hive_flutter/hive_flutter.dart';
import 'package:trader/data/data.dart';
import 'package:trader/data/source/source.dart';

class hiveHistoryDataSource implements DataSource<History> {
  final Box<History> box;

  hiveHistoryDataSource(this.box);
  @override
  Future<History> createOrUpdate(History data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(History data) async{
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(id) {
    return box.delete(id);
  }

  @override
  Future<History> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<History>> getAll({String searchKeyword = ''}) async {
    if(searchKeyword.isNotEmpty){
      
 return box.values
        .where((element) => element.currencyName.toUpperCase().contains(searchKeyword.toUpperCase()))
        .toList();
    }else{
    return  box.values.toList();
    }
   
  }
}

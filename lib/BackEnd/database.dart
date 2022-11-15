import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  static final instance = FirebaseFirestore.instance.collection("Stocks");
  static var _database;
  static var _hash = {};
  static initializeData() async {
    _database  = await instance.get();
    for (var doc in _database.docs) {
      _hash[doc['TICKER']] = {
        'TICKER' : doc['TICKER'],
        'NAME' : doc['NAME'],
        'DY' : doc['DY'],
        'LPA' : doc['LPA'],
        'PL' : doc['PL'],
        'PVP' : doc['PVP'],
        'ROE' : doc['ROE'],
        'VPA' : doc['VPA']
      };
    }
  }
  static getStock(String ticker){
    return _hash[ticker];
  }
}
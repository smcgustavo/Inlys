import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';

class DataManager {
  static List<List<dynamic>> data = [];
  late int loaded;

  DataManager(){
    loaded = 0;
  }

  loadAsset() async{
    final stringData = await rootBundle.loadString("assets/Data/Acoes.csv");
    List<List<dynamic>> csvData = const CsvToListConverter(fieldDelimiter: ",").convert(stringData, eol: "\n", fieldDelimiter: ",");
    data = csvData;
  }

  Future<String> getPriceFromTicker(String ticker) async {
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    Future<String> aux = Future<String>.value("R\$");
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        aux = Future<String>.value("R\$${data[i][1]}");
        break;
      }
    }
    return aux;
  }

  Future<String> getNameFromTicker(String ticker) async{
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    String name = "-";
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        name = data[i][2];
      }
    }
    return name;
  }


}
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';

class DataManager {
  static List<List<dynamic>> data = [];

  DataManager(){
    loadAsset();
  }

  loadAsset() async{
    final stringData = await rootBundle.loadString("assets/Data/Acoes.csv");
    List<List<dynamic>> csvData = const CsvToListConverter(fieldDelimiter: ",").convert(stringData, eol: "\n", fieldDelimiter: ",");
    data = csvData;
  }

  Future<double> getPriceFromTicker(String ticker){
    Future<double> aux = Future<double>.value(0);
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        print("entrou");
        aux = Future<double>.value(double.parse(data[i][1].toString()));
        break;
      }
    }
    return aux;
  }

}
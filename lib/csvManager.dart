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

  Future<String> getPriceFromTicker(String ticker){
    Future<String> aux = Future<String>.value("R\$");
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        print("entrou");
        aux = Future<String>.value("R\$${data[i][1]}");
        break;
      }
    }
    return aux;
  }

}
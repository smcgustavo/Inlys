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
    return getAttributeFromTicker(ticker, 1);
  }
  Future<String> getPvpFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 5);
  }
  Future<String> getDyFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 3);
  }
  Future<String> getPLFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 4);
  }
  Future<String> getRoeFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 18);
  }
  Future<String> getNameFromTicker(String ticker) async{
    return getAttributeFromTicker(ticker, 2);
  }
  Future<String> getAttributeFromTicker(String ticker, int pos) async{
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    Future<String> aux = Future<String>.value("");
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        aux = Future<String>.value("${data[i][pos]}");
        break;
      }
    }
    return aux;
  }
}
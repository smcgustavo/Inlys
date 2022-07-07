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
    return getAttributeFromTicker(ticker, 1, "R\$", "");
  }
  Future<String> getPvpFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 5,"","");
  }
  Future<String> getDyFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 3,"", "%");
  }
  Future<String> getPLFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 4,"R\$", "");
  }
  Future<String> getRoeFromTicker(String ticker) async {
    return getAttributeFromTicker(ticker, 18,"","%");
  }
  Future<String> getNameFromTicker(String ticker) async{
    return getAttributeFromTicker(ticker, 2,"","");
  }
  Future<String> getAttributeFromTicker(String ticker, int pos, String pre, String suf) async{
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    Future<String> aux = Future<String>.value("");
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        aux = Future<String>.value("$pre${data[i][pos]}$suf");
        break;
      }
    }
    return aux;
  }

  Future<double> getBetterNumberFromTicker(String ticker) async{
    double aux;
    double aux2;
    aux = (await getNumberFromTicker(ticker, 18));
    aux2 = (await getNumberFromTicker(ticker, 3));
    if(aux > aux2){
      return Future<double>.value(aux);
    }
    return Future<double>.value(aux2);
  }

  Future<double> getNumberFromTicker(String ticker, int pos) async{
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    double aux = 0.0;
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        String nova = data[i][pos].replaceAll(",",".");
        aux =  double.parse(nova);
        break;
      }
    }
    return Future<double>.value(aux);
  }
}
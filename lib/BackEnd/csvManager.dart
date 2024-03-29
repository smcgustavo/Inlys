import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';

class DataManager {
  static List<List<dynamic>> data = [];
  static int loaded = 0;

  static loadAsset() async{
    if(loaded == 0){
      final stringData = await rootBundle.loadString("assets/Data/Acoes.csv");
      List<List<dynamic>> csvData = const CsvToListConverter(fieldDelimiter: ",").convert(stringData, eol: "\n", fieldDelimiter: ",");
      data = csvData;
    }
  }

  List<List<dynamic>> getData(){
    return data;
  }

  Future<String> getPriceFromTicker(String? ticker) async {
    return await getAttributeFromTicker(ticker, 1, "R\$", "");
  }
  Future<String> getPvpFromTicker(String? ticker) async {
    return await getAttributeFromTicker(ticker, 5,"","");
  }
  Future<String> getDyFromTicker(String? ticker) async {
    return await getAttributeFromTicker(ticker, 3,"", "%");
  }
  Future<String> getPLFromTicker(String? ticker) async {
    return await getAttributeFromTicker(ticker, 4,"", "");
  }
  Future<String> getRoeFromTicker(String? ticker) async {
    return await getAttributeFromTicker(ticker, 18,"","%");
  }
  static Future<String> getNameFromTicker(String? ticker) async{
    return await getAttributeFromTicker(ticker, 2,"","");
  }
  static Future<String> getAttributeFromTicker(String? ticker, int pos, String pre, String suf) async{
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    Future<String> aux = Future<String>.value("");
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        if(data[i][pos].toString().isEmpty){
          aux = Future<String>.value("${pre}0$suf");
        }
        else{
          aux = Future<String>.value("$pre${data[i][pos]}$suf");
        }
        break;
      }
    }
    return aux;
  }

  Future<double> getPriceAsNumberFromTicker(String? ticker) async{
    if(loaded == 0){
      await loadAsset();
    }
    loaded = 1;
    double aux = 0.0;
    for(int i = 0; i < data.length; i++){
      if(data[i][0] == ticker){
        aux =  double.parse(data[i][1].toString());
        break;
      }
    }
    return Future<double>.value(aux);
  }

    Future<double> getNumberFromTicker(String? ticker, int pos) async{
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
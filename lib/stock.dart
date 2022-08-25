import 'package:flutter/material.dart';
import 'csvManager.dart';
import 'dart:math';
import 'package:inlys/yahooApi.dart';
import 'package:inlys/series.dart';

class Stock {
  late String _ticker, _type;
  late Future<String> _price, _name, _pvp, _dy, _roe, _pl, _indicator;
  late Future<String> _vpa, _lpa;
  late bool _condition;
  late List<Series> history;


  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker) {
    _condition = false;
    _ticker = ticker;
    _type = "Ação";
    loadData();
  }

  Future<String> get vpa => _vpa;

  void loadData() async {
    history = await Api.historicalSeries("$_ticker.SA", 12);
    _price = dataBase.getPriceFromTicker(_ticker);
    _vpa =  dataBase.getAttributeFromTicker(ticker, 27, "", "");
    _lpa =  dataBase.getAttributeFromTicker(ticker, 28, "", "");
    _name = dataBase.getNameFromTicker(_ticker);
    _pvp = dataBase.getPvpFromTicker(_ticker);
    _dy = dataBase.getDyFromTicker(_ticker);
    _roe = dataBase.getRoeFromTicker(_ticker);
    _pl = dataBase.getPLFromTicker(_ticker);
    loadLogo();
    graham();
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  void graham() async{
    double lpa = await dataBase.getNumberFromTicker(_ticker, 28);
    double vpa = await dataBase.getNumberFromTicker(_ticker, 27);
    double result = sqrt((lpa * vpa * 22.5));
    double? price = await Api.priceAsNumber("${ticker}F.SA");
    if(result > price){
      _condition = true;
    }
    if(result.toString() == "NaN"){
      _indicator = Future<String>.value("Indisponível");
    }
    else{
      _indicator = Future<String>.value("R\$${result.toStringAsFixed(2)}");
    }
  }

  AssetImage get logo => _logo;

  Future<String> get name => _name;

  bool get condition => _condition;

  Future<String> get pvp => _pvp;

  Future<String> get roe => _roe;

  Future<String> get pl => _pl;

  Future<String> get indicator => _indicator;

  Future<String> get price => _price;

  Future<String> get dy => _dy;

  String get type => _type;

  String get ticker => _ticker.toString();

  get lpa => _lpa;
}
import 'package:flutter/material.dart';
import 'csvManager.dart';

class Stock {
  late String _ticker, _type;
  late Future<String> _price, _name, _pvp, _dy, _roe, _pl;


  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker){
    _ticker = ticker;
    _type = "Ação";
    loadData();
  }

  void loadData(){
    loadLogo();
    _price = dataBase.getPriceFromTicker(_ticker);
    _name = dataBase.getNameFromTicker(_ticker);
    _pvp = dataBase.getPvpFromTicker(_ticker);
    _dy = dataBase.getDyFromTicker(_ticker);
    _roe = dataBase.getRoeFromTicker(_ticker);
    _pl = dataBase.getPLFromTicker(_ticker);
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  AssetImage get logo => _logo;

  Future<String> get name => _name;

  Future<String> get pvp => _pvp;

  Future<String> get roe => _roe;

  Future<String> get pl => _pl;

  Future<String> get price => _price;

  Future<String> get dy => _dy;

  String get type => _type;

  String get ticker => _ticker.toString();
}
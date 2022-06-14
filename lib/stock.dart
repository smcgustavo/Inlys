import 'package:flutter/material.dart';
import 'csvManager.dart';

class Stock {
  late String _ticker, _type;
  late double _pvp, _roe;
  late Future<String> _price, _name;


  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker){
    _roe = 3.14;
    _ticker = ticker;
    _type = "Ação";
    loadData();
  }

  void loadData(){
    loadLogo();
    _price = dataBase.getPriceFromTicker(_ticker);
    _name = dataBase.getNameFromTicker(_ticker);
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  AssetImage get logo => _logo;

  String get roe => _roe.toString();

  Future<String> get name => _name;

  String get pvp => _pvp.toString();

  Future<String> get price => _price;

  String get type => _type;

  String get ticker => _ticker.toString();
}
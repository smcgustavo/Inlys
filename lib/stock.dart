import 'package:flutter/material.dart';
import 'csvManager.dart';

class Stock {
  late String _ticker, _name, _type;
  late double _pvp, _roe;
  late Future<String> _price;


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
    _name = "Petrobras";
    _price = dataBase.getPriceFromTicker(_ticker);
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  AssetImage get logo => _logo;

  String get roe => _roe.toString();

  String get name => _name;

  String get pvp => _pvp.toString();

  Future<String> get price => _price;

  String get type => _type;

  String get ticker => _ticker.toString();
}
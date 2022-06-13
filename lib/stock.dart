import 'package:flutter/material.dart';
import 'csvManager.dart';

class Stock {
  late String _ticker, _name, _type;
  late double _pvp, _roe;
  late Future<double> _price;


  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker){
    _roe = 3.14;
    _ticker = ticker;
    _type = "Ação";
    dataBase.loadAsset();
    loadData();
    _price = dataBase.getPriceFromTicker(_ticker);
  }

  void loadData(){
    loadLogo();
    _name = "Petrobras";

  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }


  AssetImage get logo => _logo;

  String get roe => _roe.toString();

  String get name => _name;

  String get pvp => _pvp.toString();

  Future<double> get price => _price;

  String get type => _type;

  String get ticker => _ticker.toString();
}
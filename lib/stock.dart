import 'package:flutter/material.dart';

class Stock {
  late String _ticker;
  late double _price, _pvp, _roe;
  late AssetImage _logo;

  Stock(String ticker){
    _ticker = ticker;
    loadData();
  }

  void loadData(){
    loadLogo();
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }


  AssetImage get logo => _logo;

  String get roe => _roe.toString();

  String get pvp => _pvp.toString();

  String get price => _price.toString();

  String get ticker => _ticker;
}
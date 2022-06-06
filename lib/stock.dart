import 'package:flutter/material.dart';

class Stock {
  late String _ticker, _name, _type;
  late double _price, _pvp, _roe;
  late AssetImage _logo;

  Stock(String ticker){
    _roe = 3.14;
    _price = 13.14;
    _ticker = ticker;
    _type = "Ação";
    loadData();
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

  String priceFormated(){
    return "R\$ ${_price.toString()}";
  }

  String get type => _type;

  String get ticker => _ticker.toString();
}
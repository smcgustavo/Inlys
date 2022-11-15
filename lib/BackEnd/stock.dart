import 'package:flutter/material.dart';
import 'csvManager.dart';
import 'dart:math';
import 'package:inlys/BackEnd/yahooApi.dart';
import 'database.dart';

class Stock {
  late String _ticker, _type;
  late Future<String> _price; // <- mais lerdo
  late String _pvp, _dy, _roe, _pl,_lpa, _vpa;
  late String _name;
  late Future<String> _indicator;
  late bool _condition;
  late Future<double> _grahamPrice;


  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker) {
    _condition = false;
    _ticker = ticker;
    _type = "Ação";
    loadData();
  }

  void loadData()  {
    loadAttributes();
    _price = dataBase.getPriceFromTicker(_ticker);
    _indicator = Future<String>.value("Indisponível");
    loadLogo();
  }

  void loadAttributes() {
    var attributes = Database.getStock(_ticker);
    _name = attributes['NAME'];
    _vpa = attributes['VPA'];
    _lpa = attributes['LPA'];
    _pvp = attributes['PVP'];
    _roe = attributes['ROE'];
    _dy = attributes['DY'].toString();
    _pl = attributes['PL'];
    grahamPrice();
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  void grahamPrice() async {
    double lpa = double.parse(_lpa.replaceAll(',', '.'));
    double vpa = double.parse(_vpa.replaceAll(',', '.'));
    double result = sqrt((lpa * vpa * 22.5));
    _grahamPrice = Future<double>.value(result);
    _indicator = Future<String>.value("R\$ ${result.toStringAsFixed(2)}");
    double? price = await Api.priceAsNumber("${_ticker}F.SA");
    double graham = await _grahamPrice;
    if(graham > price){
      _condition = true;
    }
    if(lpa < 0 || vpa < 0){
      _indicator = Future<String>.value("Indisponível");
      _condition = false;
    }
  }

  AssetImage get logo => _logo;

  String get name => _name;

  String get vpa => _vpa;

  bool get condition => _condition;

  String get pvp => _pvp;

  String get roe => _roe;

  String get pl => _pl;

  Future<String> get indicator => _indicator;

  Future<String> get price => _price;

  String? get dy => _dy;

  String get type => _type;

  String get ticker => _ticker.toString();

  get lpa => _lpa;
}
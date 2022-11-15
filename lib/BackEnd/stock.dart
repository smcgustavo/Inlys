import 'package:flutter/material.dart';
import 'csvManager.dart';
import 'dart:math';
import 'package:inlys/BackEnd/yahooApi.dart';
import 'database.dart';

class Stock {
  late String _ticker, _type;
  late Future<String> _price; // <- mais lerdo
  late String _pvp, _dy, _roe, _pl, _lpa, _vpa;
  late String _name;
  late Future<Text> graham;

  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker) {
    _ticker = ticker;
    _type = "Ação";
    loadData();
  }

  void loadData() {
    _price = dataBase.getPriceFromTicker(_ticker);
    loadAttributes();
    loadLogo();
  }

  void loadAttributes() {
    var attributes = Database.getStock(_ticker);
    _vpa = attributes['VPA'];
    _lpa = attributes['LPA'];
    grahamPrice();
    _pvp = attributes['PVP'];
    _roe = attributes['ROE'];
    _dy = attributes['DY'].toString();
    _pl = attributes['PL'];
    _name = attributes['NAME'];
  }

  void loadLogo() {
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0, 4)}.jpg');
  }

  Future<Text> grahamPrice() async {
    double lpa = double.parse(_lpa.replaceAll(",", '.'));
    double vpa = double.parse(_vpa.replaceAll(",", '.'));
    if(lpa < 0 || vpa < 0){
      return  Future<Text>.value(const Text("Indisponível",
          style: TextStyle(color: Colors.redAccent, fontSize: 18)));
    }
    double result = sqrt(lpa * vpa * 22.5);
    double price = await Api.priceAsNumber("$_ticker.SA");
    if(result > price){
      return  Future<Text>.value(Text("R\$ ${result.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.greenAccent, fontSize: 18))) ;
    }
    else{
      return Future<Text>.value(Text("R\$ ${result.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.redAccent, fontSize: 18))) ;
    }
  }

  AssetImage get logo => _logo;

  String get name => _name;

  Future<Text> get grahamTextWidget => graham;

  String get vpa => _vpa;

  String get pvp => _pvp;

  String get roe => _roe;

  String get pl => _pl;

  Future<String> get price => _price;

  String? get dy => _dy;

  String get type => _type;

  String get ticker => _ticker.toString();

  get lpa => _lpa;
}
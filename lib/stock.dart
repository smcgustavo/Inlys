import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:flutter/material.dart';
import 'csvManager.dart';
import 'dart:math';
import 'package:inlys/yahooApi.dart';
import 'dynamoDB.dart';

class Stock {
  late String _ticker, _type;
  late Future<String> _price; // <- mais lerdo
  late String? _name, _pvp, _dy, _roe, _pl;
  late Future<String> _indicator;
  late Future<String?> _lpa, _vpa;
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
    _price = dataBase.getPriceFromTicker(_ticker);
    _indicator = Future<String>.value("Indisponível");
    loadAttributes();
    loadLogo();
  }

  void loadAttributes() async{
    Map<String, AttributeValue> attributes = await Dynamo.getItem(_ticker);
    _vpa = Future<String?>.value(attributes['VPA']?.s);
    _lpa = Future<String?>.value(attributes['LPA']?.s);
    _name = attributes['NAME']?.s;
    _pvp = attributes['P/VP']?.s;
    _roe = attributes['ROE']?.s;
    _dy = attributes['DY']?.s;
    _pl = attributes['P/L']?.s;
    grahamPrice();
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  void grahamPrice() async {
    String? lpaString = await _lpa;
    double lpa = double.parse(lpaString!.replaceAll(',', '.'));
    String? vpaString = await _vpa;
    double vpa = double.parse(vpaString!.replaceAll(',', '.'));
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

  String? get name => _name;

  Future<String?> get vpa => _vpa;

  bool get condition => _condition;

  String? get pvp => _pvp;

  String? get roe => _roe;

  String? get pl => _pl;

  Future<String> get indicator => _indicator;

  Future<String> get price => _price;

  String? get dy => _dy;

  String get type => _type;

  String get ticker => _ticker.toString();

  get lpa => _lpa;
}
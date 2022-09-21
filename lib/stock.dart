import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:flutter/material.dart';
import 'csvManager.dart';
import 'dart:math';
import 'package:inlys/yahooApi.dart';
import 'dynamoDB.dart';

class Stock {
  late String _ticker, _type;
  late Future<String> _price,  _indicator; // <- mais lerdo
  late String? _vpa, _name, _pvp, _dy, _roe, _pl, _lpa;
  late bool _condition;


  late AssetImage _logo;
  static DataManager dataBase = DataManager();

  Stock(String ticker) {
    _condition = false;
    _indicator = Future<String>.value("Indisponível");
    _ticker = ticker;
    _type = "Ação";
    loadData();
  }



  void loadData()  {
    _price = dataBase.getPriceFromTicker(_ticker);
    //_vpa =  dataBase.getAttributeFromTicker(ticker, 27, "", "");
    //_lpa =  dataBase.getAttributeFromTicker(ticker, 28, "", "");
    //_name = dataBase.getNameFromTicker(_ticker);
    //_pvp = dataBase.getPvpFromTicker(_ticker);
    //_dy = dataBase.getDyFromTicker(_ticker);
    //_roe = dataBase.getRoeFromTicker(_ticker);
    //_pl = dataBase.getPLFromTicker(_ticker);
    loadAttributes();
    loadLogo();
    graham();
  }

  void loadAttributes() async{
    Map<String, AttributeValue> attributes = await Dynamo.getItem(_ticker);
    _vpa = attributes['VPA']?.s;
    _lpa = attributes['LPA']?.s;
    _name = attributes['NAME']?.s;
    _pvp = attributes['P/VP']?.s;
    _roe = attributes['ROE']?.s;
    _dy = attributes['DY']?.s;
    _pl = attributes['P/L']?.s;
  }

  void loadLogo(){
    _logo = AssetImage('assets/images/stocksIcons/${_ticker.substring(0,4)}.jpg');
  }

  void graham() async {
    double lpa = await dataBase.getNumberFromTicker(_ticker, 28);
    double vpa = await dataBase.getNumberFromTicker(_ticker, 27);
    double result = sqrt((lpa * vpa * 22.5));
    double? price = await Api.priceAsNumber("${ticker}F.SA");
    if(result > price){
      _condition = true;
    }
    if(result.toString() == "NaN" || (vpa < 0 && lpa < 0)){
      _indicator = Future<String>.value("Indisponível");
      _condition = false;
    }
    else{
      _indicator = Future<String>.value("R\$${result.toStringAsFixed(2)}");
    }
  }

  AssetImage get logo => _logo;

  String? get name => _name;

  String? get vpa => _vpa;

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
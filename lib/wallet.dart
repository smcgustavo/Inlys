import 'package:flutter/material.dart';
import 'package:inlys/stockBlock.dart';
import 'package:inlys/stock.dart';

class Wallet {
  static List<Widget> favoriteStocks = <Widget> [];

  Wallet(){
    Stock a = Stock("BBAS3");
    Stock b = Stock("PETR4");
    Stock c = Stock("GOLL4");
    Stock d = Stock("MGLU3");
    Stock e = Stock("BBDC4");
    Stock f = Stock("ITUB4");
    Stock g = Stock("ABEV3");
    Stock h = Stock("VALE3");
    Stock i = Stock("BIDI4");

    favoriteStocks = <Widget> [
      StockBlock(
        stock: a,
      ),
      StockBlock(
        stock: b,
      ),
      StockBlock(
        stock: c,
      ),
      StockBlock(
        stock: d,
      ),
      StockBlock(
        stock: e,
      ),
      StockBlock(
        stock: f,
      ),
      StockBlock(
        stock: g,
      ),
      StockBlock(
        stock: h,
      ),
      StockBlock(
          stock: i
      )
    ];
  }

  void addStock(String ticker){
    Stock aux = Stock(ticker);
    StockBlock aux2 = StockBlock(stock: aux);
    favoriteStocks.add(aux2);
  }

  List<Widget> getWallet(){
    return favoriteStocks;
  }

}

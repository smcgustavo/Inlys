import 'package:flutter/material.dart';
import 'package:inlys/stockBlock.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/profile.dart';

class Wallet {
  static List<Widget> favoriteStocks = <Widget> [];

  void initializeWallet(Profile user){
    Stock a = Stock("BBAS3");
    Stock b = Stock("PETR4");
    Stock c = Stock("GOLL4");
    Stock d = Stock("BIDI4");
    Stock e = Stock("BBDC4");
    Stock f = Stock("ITUB4");
    Stock g = Stock("ABEV3");
    Stock h = Stock("VALE3");
    Stock i = Stock("MGLU3");

    favoriteStocks = <Widget> [
      StockBlock(
        stock: a,
        user: user,
      ),
      StockBlock(
        stock: b,
        user: user,
      ),
      StockBlock(
        stock: c,
        user: user,
      ),
      StockBlock(
        stock: d,
        user: user,
      ),
      StockBlock(
        stock: e,
        user: user,
      ),
      StockBlock(
        stock: f,
        user: user,
      ),
      StockBlock(
        stock: g,
        user: user,
      ),
      StockBlock(
        stock: h,
        user: user,
      ),
      StockBlock(
          stock: i,
          user: user,
      )
    ];
  }

  void addStock(String ticker, Profile user){
    Stock aux = Stock(ticker);
    StockBlock aux2 = StockBlock(stock: aux, user: user,);
    favoriteStocks.add(aux2);
  }

  List<Widget> getWallet(){
    return favoriteStocks;
  }
}
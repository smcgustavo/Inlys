import 'package:yahoofin/yahoofin.dart';
import 'package:flutter/material.dart';

class Api {
  static YahooFin yfin = YahooFin();
  static Future<String> price(String ticker, String prefix) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPrice();
    String string = "";
    string = prefix + quote.currentPrice.toString().replaceAll(".", ",");
    return string;
  }

  static Future<double?> priceAsNumber(String ticker) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPrice();
    double? number = quote.currentPrice;
    return number;
  }

  static Future<String> change(String ticker, String prefix) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote2 = await info.getStockPriceChange();
    String string = quote2.regularMarketChangePercent.toString();
    string = "${string.substring(0,6).replaceAll(".", ",")}%";
    return string;
  }
  static Future<double?> changeAsNumber(String ticker, String prefix) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPriceChange();
    double? number = quote.regularMarketChangePercent;
    return number;
  }

  static Future<Color> color(String ticker) async{
    Color result = Colors.greenAccent;
    double? aux = await changeAsNumber(ticker, "");
    if(aux! < 0){
      result = Colors.redAccent;
    }
    return result;
  }
}
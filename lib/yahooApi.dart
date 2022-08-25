import 'package:yahoofin/yahoofin.dart';
import 'package:flutter/material.dart';
import 'series.dart';

class Api {
  static YahooFin yfin = YahooFin();
  static Future<String> price(String ticker, String prefix) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPrice();
    String string = "";
    string = prefix + quote.currentPrice.toString().replaceAll(".", ",");
    return string;
  }

  static Future<double> priceAsNumber(String ticker) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPrice();
    double? number = quote.currentPrice;
    return number!;
  }

  static Future<String> change(String ticker, String prefix, int size) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote2 = await info.getStockPriceChange();
    String string = quote2.regularMarketChangePercent.toString();
    if(string[0] == '-'){
      size++;
    }
    string = "${string.substring(0, size + 1).replaceAll(".", ",")}%";
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

  static Future<String> changeWeek(String ticker, String prefix, int size) async{
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.oneDay,
        period: StockRange.oneMonth
    );
    List<num>? aux = chart.chartQuotes?.close;
    String result = (((aux![aux.length - 1] - aux![aux.length - 5 - 1]) / aux![aux.length - 5 - 1]) * 100).toStringAsFixed(2);
    return "${result}%";
  }

  static Future<double?> changeWeekAsNumber(String ticker, String prefix) async {
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.oneDay,
        period: StockRange.oneMonth
    );
    List<num>? aux = chart.chartQuotes?.close;
    double result = ((aux![aux.length - 1] - aux![aux.length - 5 - 1]) / aux![aux.length - 5 - 1]) * 100;
    return result;
  }

  static Future<Color> colorWeek(String ticker) async{
    Color result = Colors.greenAccent;
    double? aux = await changeWeekAsNumber(ticker, "");
    if(aux! < 0){
      result = Colors.redAccent;
    }
    return result;
  }

  static Future<String> changeMonth(String ticker, String prefix, int size) async{
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.ninetyMinute,
        period: StockRange.oneMonth
    );
    List<num>? aux = chart.chartQuotes?.close;
    String result = (((aux![aux.length - 1] - aux![0]) / aux![0]) * 100).toStringAsFixed(2);
    return "${result}%";
  }

  static Future<double?> changeMonthAsNumber(String ticker, String prefix) async {
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.ninetyMinute,
        period: StockRange.oneMonth
    );
    List<num>? aux = chart.chartQuotes?.close;
    double result = ((aux![aux.length - 1] - aux![0]) / aux![0]) * 100;
    return result;
  }

  static Future<Color> colorMonth(String ticker) async{
    Color result = Colors.greenAccent;
    double? aux = await changeMonthAsNumber(ticker, "");
    if(aux! < 0){
      result = Colors.redAccent;
    }
    return result;
  }

  static Future<String> changeYear(String ticker, String prefix, int size) async{
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.fiveDay,
        period: StockRange.oneYear
    );
    List<num>? aux = chart.chartQuotes?.close;
    String result = (((aux![aux.length - 1] - aux![0]) / aux![0]) * 100).toStringAsFixed(2);
    return "${result}%";
  }

  static Future<double?> changeYearAsNumber(String ticker, String prefix) async {
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.fiveDay,
        period: StockRange.oneYear
    );
    List<num>? aux = chart.chartQuotes?.close;
    double result = ((aux![aux.length - 1] - aux![0]) / aux![0]) * 100;
    return result;
  }

  static Future<Color> colorYear(String ticker) async{
    Color result = Colors.greenAccent;
    double? aux = await changeYearAsNumber(ticker, "");
    if(aux! < 0){
      result = Colors.redAccent;
    }
    return result;
  }

  static Future<List<Series>> historicalSeries(String ticker, int months) async{
    StockChart chart;
    if(months == 12){
      chart = await yfin.getChartQuotes(
          stockHistory: yfin.initStockHistory(ticker: ticker),
          interval: StockInterval.oneWeek,
          period: StockRange.oneYear
      );
    }
    else if(months == 6){
      chart = await yfin.getChartQuotes(
          stockHistory: yfin.initStockHistory(ticker: ticker),
          interval: StockInterval.fiveDay,
          period: StockRange.sixMonth
      );
    }
    else if(months == 3){
      chart = await yfin.getChartQuotes(
          stockHistory: yfin.initStockHistory(ticker: ticker),
          interval: StockInterval.oneDay,
          period: StockRange.threeMonth
      );
    }
    else if(months == 1){
      chart = await yfin.getChartQuotes(
          stockHistory: yfin.initStockHistory(ticker: ticker),
          interval: StockInterval.oneDay,
          period: StockRange.oneMonth
      );
    }
    else{
      chart = await yfin.getChartQuotes(
          stockHistory: yfin.initStockHistory(ticker: ticker),
          interval: StockInterval.oneWeek,
          period: StockRange.oneYear
      );
    }

    ChartQuotes result = chart.chartQuotes!;
    List<Series> series = [];
    for(var i = 0; i < result.close!.length; i++){
      DateTime aux = DateTime.fromMillisecondsSinceEpoch(result.timestamp![i].toInt() * 1000);
      series.add(Series(result.close![i], aux));
    }
    return series;
  }
}

/*static Future<List<Series>> historicalSeries(String ticker) async{
    StockChart chart = await yfin.getChartQuotes(
        stockHistory: yfin.initStockHistory(ticker: ticker),
        interval: StockInterval.fiveDay,
        period: StockRange.oneYear
    );
    ChartQuotes result = chart.chartQuotes!;
    List<Series> series = [];
    for(var i = 0; i < result.close!.length; i++){
      DateTime aux = DateTime.fromMillisecondsSinceEpoch(result.timestamp![i].toInt() * 1000);
      series.add(Series(result.close![i], aux));
    }
    return series;
  }*/
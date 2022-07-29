import 'package:yahoofin/yahoofin.dart';

class Api {
  static YahooFin yfin = YahooFin();
  static Future<String> price(String ticker, String prefix) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPrice();
    String string = "";
    string = prefix + quote.currentPrice.toString().replaceAll(".", ",");
    return string;
  }
}
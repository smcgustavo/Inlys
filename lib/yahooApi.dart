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
  static Future<String> change(String ticker, String prefix) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote2 = await info.getStockPriceChange();
    String string = quote2.regularMarketChangePercent.toString();
    string = "${string.substring(0,6).replaceAll(".", ",")}%";
    return string;
  }
}
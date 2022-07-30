import 'package:inlys/stock.dart';
import 'package:inlys/profile.dart';

class Wallet {
  static List<Stock> favoriteStocks = <Stock> [];

  Wallet(){
    initializeWallet();
  }

  void initializeWallet(){
    Stock a = Stock("BBAS3");
    Stock b = Stock("PETR4");
    Stock c = Stock("GOLL4");
    Stock d = Stock("BIDI4");
    Stock e = Stock("BBDC4");
    Stock f = Stock("ITUB4");
    Stock g = Stock("ABEV3");
    Stock h = Stock("VALE3");
    Stock i = Stock("MGLU3");

    favoriteStocks = <Stock> [
      a,
      b,
      c,
      d,
      e,
      f,
      g,
      h,
      i
    ];
  }

  void addStock(String ticker, Profile user){
    Stock aux = Stock(ticker);
    favoriteStocks.add(aux);
  }

  List<Stock> getWallet(){
    initializeWallet();
    return favoriteStocks;
  }
}
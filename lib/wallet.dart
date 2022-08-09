import 'package:inlys/stock.dart';

class Wallet {
  static List<Stock> favoriteStocks = <Stock> [];

  Wallet(){
    initializeWallet();
  }

  static void initializeWallet(){
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

  static void addStock(String ticker){
    Stock aux = Stock(ticker);
    favoriteStocks.add(aux);
  }

  static void removeStock(String ticker){
    for(int i = 0; i < favoriteStocks.length;i++){
      if(favoriteStocks[i].ticker == ticker){
        favoriteStocks.removeAt(i);
        break;
      }
    }
  }

  static List<Stock> getWallet(){
    return favoriteStocks;
  }
}
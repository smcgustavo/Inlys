import 'package:inlys/BackEnd/stock.dart';
import 'package:get_storage/get_storage.dart';

class Wallet {
  static List<Stock> favoriteStocks = <Stock> [];
  static List<String> stocksString = [];
  static var disco = GetStorage();

  static void initializeWallet(){
    var aux = disco.read("favoriteStocks");
    if(aux == null){
      stocksString = [];
    }
    else{
      stocksString = aux.cast<String>();
    }
    for(int i = 0; i < stocksString.length; i++){
      favoriteStocks.add(Stock(stocksString[i]));
    }
  }

  static void addStock(String ticker) async{
    for(int i = 0; i < favoriteStocks.length; i++){
      if(favoriteStocks[i].ticker == ticker){
        return;
      }
    }
    Stock aux = Stock(ticker);
    favoriteStocks.add(aux);
    stocksString.add(ticker);
    await disco.write("favoriteStocks", stocksString);
  }

  static void removeStock(String ticker) async {
    for(int i = 0; i < favoriteStocks.length;i++){
      if(favoriteStocks[i].ticker == ticker){
        favoriteStocks.removeAt(i);
        stocksString.removeAt(i);
        await disco.write("favoriteStocks", stocksString);
        break;
      }
    }
  }

  static List<Stock> getWallet(){
    return favoriteStocks;
  }
  static List<String> getWalletString(){
    return stocksString;
  }
}
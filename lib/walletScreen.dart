import 'package:flutter/material.dart';
import 'package:inlys/stockBlock.dart';
import 'package:inlys/wallet.dart';
import 'package:inlys/addStockScreen.dart';
import 'package:inlys/stock.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key, required this.allStocks}) : super(key: key);
  List<String> allStocks;
  Wallet wallet = Wallet();
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  late List<Stock> stocks = widget.wallet.getWallet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Center(
            child: Scrollbar(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final StockBlock aux = StockBlock(stock: stocks[index]);
                return aux;
              },
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchStock(allStocks: widget.allStocks),
              ));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

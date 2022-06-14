import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/stockBlock.dart';

class WalletScreen extends StatefulWidget{
  const WalletScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>{

  Stock a = Stock("BBAS3");
  Stock b = Stock("PETR4");
  Stock c = Stock("GOLL4");
  Stock d = Stock("MGLU3");
  Stock e = Stock("BBDC4");
  Stock f = Stock("ITUB4");
  Stock g = Stock("ABEV3");
  Stock h = Stock("VALE3");
  Stock i = Stock("BIDI4");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35),
        child: AppBar(
          title: const Text("Sua Carteira"),
          centerTitle: false,
          backgroundColor: Colors.black,
        ),
      ),
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: Center(
        child:
           ListView(
            padding:  const EdgeInsets.all(10),
            children:  <Widget>[
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
            ],
          )
      )

    );
  }

}
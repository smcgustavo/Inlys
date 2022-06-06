import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';

class WalletScreen extends StatefulWidget{
  const WalletScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>{

  Stock a = Stock("BBAS3");
  Stock b = Stock("PETR4");

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
            ],
          )
      )

    );
  }

}

class StockBlock extends StatelessWidget{

  const StockBlock({
    required this.stock
  });

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 90,
            color: Colors.white.withOpacity(0.1),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 90,
                    width: 90,
                    color: Colors.white.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                          child: Image(image: stock.logo)
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
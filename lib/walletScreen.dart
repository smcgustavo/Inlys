import 'package:flutter/material.dart';
import 'package:inlys/wallet.dart';
import 'package:inlys/addStockScreen.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key, required this.allStocks}) : super(key: key);
  List<String> allStocks;
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  Wallet wallet = Wallet();
  @override
  Widget build(BuildContext context) {
    wallet.initializeWallet();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Center(
            child: Scrollbar(
          child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: wallet.getWallet()),
        )),
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

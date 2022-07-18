import 'package:flutter/material.dart';
import 'package:inlys/wallet.dart';
import 'package:inlys/profile.dart';
import 'package:inlys/addStockScreen.dart';

class WalletScreen extends StatefulWidget {
  Profile user;
  WalletScreen({Key? key, required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  Wallet wallet = Wallet();
  @override
  Widget build(BuildContext context) {
    wallet.initializeWallet(widget.user);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: Center(
          child: Scrollbar(
        child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            children: wallet.getWallet()),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchStock(),
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

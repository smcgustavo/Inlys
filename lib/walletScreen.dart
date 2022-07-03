import 'package:flutter/material.dart';
import 'package:inlys/wallet.dart';

class WalletScreen extends StatefulWidget{
  const WalletScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>{
  Wallet wallet = Wallet();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: Center(
        child:
           ListView(
            padding:  const EdgeInsets.all(10),
            children:  wallet.getWallet()
          )
      )

    );
  }

}
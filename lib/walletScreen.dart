import 'package:flutter/material.dart';
import 'package:inlys/wallet.dart';
import 'package:inlys/profile.dart';

class WalletScreen extends StatefulWidget{
  Profile user;
  WalletScreen({Key? key,  required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>{
  Wallet wallet = Wallet();
  @override
  Widget build(BuildContext context) {
    wallet.initializeWallet(widget.user);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: Center(
        child:
            Scrollbar(
              child: ListView(
                padding:  const EdgeInsets.all(10),
                children:  wallet.getWallet()
              ),
            )

      )

    );
  }

}
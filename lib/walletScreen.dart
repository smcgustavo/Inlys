import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget{
  const WalletScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(31, 31, 31, 1),
      body: Text("Wallet!"),
    );
  }

}
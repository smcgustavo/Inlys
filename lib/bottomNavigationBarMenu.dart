import 'package:flutter/material.dart';
import 'package:inlys/walletScreen.dart';
import 'package:inlys/StockScreen.dart';
import 'package:inlys/stock.dart';

class BottomNavigation extends StatefulWidget{
  const BottomNavigation({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation>{


  int _selectedIndex = 0;
  static const TextStyle style = TextStyle(color: Colors.white, fontSize: 26);
  static List<Widget> screens = <Widget>[
    const WalletScreen(),
    const Text("Index 1: Profile", style: style,),
    StockScreen(stock: Stock("PETR4")),
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Carteira'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Perfil'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Ações'
          )
        ],
      ),
    );
  }
}
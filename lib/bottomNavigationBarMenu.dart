import 'package:flutter/material.dart';
import 'package:inlys/walletScreen.dart';
import 'package:inlys/configMenu.dart';
import 'package:inlys/profile.dart';

class BottomNavigation extends StatefulWidget{
  Profile user;
  BottomNavigation({Key? key, required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation>{
  int _selectedIndex = 0;
  static const TextStyle style = TextStyle(color: Colors.white, fontSize: 26);

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      //WalletScreen(allStocks: ,),
      const Text("Index 2: Sob Construção", style: TextStyle(color: Colors.black)),
      ConfigMenu()
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: AppBar(
          title: const Text(""),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      ),
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
              icon: Icon(Icons.account_balance),
              label: 'Ações'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações'
          )
        ],
      ),
    );
  }
}
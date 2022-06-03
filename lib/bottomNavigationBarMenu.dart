import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget{
  const BottomNavigation({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => BottomNavigationState();

}
class BottomNavigationState extends State<BottomNavigation>{

  int _selectedIndex = 0;
  static const TextStyle style = TextStyle(color: Colors.white, fontSize: 26);
  static const List<Widget> screens = <Widget>[
    Text("Index 0: Your Wallet", style: style,),
    Text("Index 1: Profile", style: style,),
    Text("Index 2: Stocks", style: style,)
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
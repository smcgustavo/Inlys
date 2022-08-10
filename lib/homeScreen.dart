import 'package:flutter/material.dart';
import 'package:inlys/walletScreen.dart';
import 'addStockScreen.dart';
import 'package:inlys/yahooApi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.allStocks});
  final List<String> allStocks;
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.black,
        ),
      ),
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 35, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("Índices:", style: TextStyle(color: Colors.white, fontSize: 28),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  futureIndicator("S&P500", Api.price("^GSPC", ""), Api.change("^GSPC", "", 4), "^GSPC"),
                  futureIndicator("Ibovespa", Api.price("^BVSP", "") , Api.change("^BVSP", "",4), "^BVSP")
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, top: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Moedas:", style: TextStyle(color: Colors.white, fontSize: 28),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  futureIndicator("Dólar", Api.price("BRL=X", "R\$"), Api.change("BRL=X", "",4), "BRL=X"),
                  futureIndicator("Euro", Api.price("EURBRL=X", "R\$"), Api.change("EURBRL=X", "",4), "EURBRL=X"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20), 
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WalletScreen(allStocks: widget.allStocks,))
                      );
                    },
                    child: otherPage("Sua Carteira", Icons.wallet))
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchStock(allStocks: widget.allStocks))
                      );
                    },
                    child: otherPage("Todas as Ações", Icons.account_balance))
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: appLogo(),
            )
          ],
        ),
      ),
    );
  }

  Widget header(String name) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black87.withOpacity(0.1),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
              size: 42,
            ),
            const SizedBox(width: 20),
            Text(
              "Olá, $name",
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }

  Widget indicator(String indicator, String value, String difference, IconData icon, Color iconColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10)
        ),
        height: 100,
        width: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                indicator,
                style: const TextStyle(color: Colors.white,fontSize: 18),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    difference,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Icon(icon,
                    color: difference[0] == '-' ? Colors.redAccent : Colors.greenAccent,
                    size: 30,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget futureIndicator(String indicator, Future<String> value, Future<String> difference, String ticker) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10)
        ),
        height: 150,
        width: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                indicator,
                style: const TextStyle(color: Colors.white,fontSize: 18),
              ),
              FutureText(text: value, style: const TextStyle(color: Colors.white,fontSize: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureText(text: difference, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  FutureIcon(color: Api.color(ticker))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget otherPage(String text, IconData icon){
    return  ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: 80,
            width: 325,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                )
              ],
            ),
          ),
    );
  }
  Widget appLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/iconLauncher/icon.png",
          width: 40,
          height: 40,
        ),
        const SizedBox(width: 20,),
        const Text("Alys",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22
          )
          ,)
      ],
    );
  }
}

class FutureText<String> extends StatelessWidget {
  const FutureText({Key? key, required this.text, required this.style});

  final Future<String> text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: text,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[Text('${snapshot.data}', style: style)];
        } else {
          children = <Widget>[
            const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                color: Colors.white38,
              ),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}

class FutureIcon<String> extends StatelessWidget {
  const FutureIcon({Key? key, required this.color});

  final Future<Color> color;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: color,
      builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          if(snapshot.data == Colors.redAccent){
            children = <Widget>[
              Icon(
                Icons.trending_down,
                color: snapshot.data,
              )
            ];
          }
          else {
            children = <Widget>[
              Icon(
                Icons.trending_up,
                color: snapshot.data,
              )
            ];
          }
        } else {
          children = <Widget>[
            const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                color: Colors.white38,
              ),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
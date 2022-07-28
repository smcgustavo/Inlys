import 'package:flutter/material.dart';
import 'package:inlys/walletScreen.dart';
import 'addStockScreen.dart';
import 'package:yahoofin/yahoofin.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.allStocks});
  List<String> allStocks;
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final yfin = YahooFin();
  @override
  Widget build(BuildContext context) {
    StockInfo bovespa = yfin.getStockInfo(ticker: "^BVSP");
    StockInfo dolar = yfin.getStockInfo(ticker: "USDBRL=X");
    Future<StockQuote> ibov = bovespa.getStockPrice();
    Future<StockQuote> dol = dolar.getStockPrice();
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
            //header("Gustavo"),
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  futureIndicator("Dólar", Tratamento.price("USDBRL=X", "R\$", yfin), "0.32%", Icons.trending_up, Colors.greenAccent),
                  futureIndicator("Ibovespa", Tratamento.price("^BVSP", "", yfin) , "0.55%", Icons.trending_up, Colors.greenAccent)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  indicator("Ipca", "0.13%", "-0.42%", Icons.trending_down, Colors.redAccent),
                  indicator("CDI", "13.25%", "0.25%", Icons.trending_up, Colors.greenAccent)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20), 
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
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
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchStock(allStocks: widget.allStocks))
                      );
                    },
                    child: otherPage("Todas as Ações", Icons.account_balance))
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
        color: Colors.white.withOpacity(0.1),
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white70, width: 1),
          color: Colors.white.withOpacity(0.10)
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
                  Icon(icon, color: iconColor, size: 30,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget futureIndicator(String indicator, Future<String> value, String difference, IconData icon, Color iconColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white70, width: 1),
            color: Colors.white.withOpacity(0.10)
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
                  Text(
                    difference,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Icon(icon, color: iconColor, size: 30,)
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
        borderRadius: BorderRadius.circular(20),
        child: Container(
            height: 100,
            width: 340,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(20)
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
        const Text("Inlys",
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

class Tratamento {
  static Future<String> price(String ticker, String prefix, YahooFin yfin) async {
    StockInfo info = yfin.getStockInfo(ticker: ticker);
    StockQuote quote = await info.getStockPrice();
    String string = "";
    string = prefix + quote.currentPrice.toString().replaceAll(".", ",");
    return string;
  }
  
}
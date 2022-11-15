import 'package:flutter/material.dart';
import 'package:inlys/Widgets/walletScreen.dart';
import 'addStockScreen.dart';
import 'package:inlys/BackEnd/yahooApi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        elevation: 0,
        leading: appLogo(),
        title: const Text("Alys",
          style: TextStyle(
              color: Colors.white,
              fontSize: 26
          )
          ,),
      ),
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const WalletScreen())
                          );
                        },
                        child: otherPage("Carteira", Icons.wallet))
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const SearchStock())
                          );
                        },
                        child: otherPage("Busca", Icons.search))
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("Índices:", style: TextStyle(color: Colors.white, fontSize: 28),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
              child: Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(5),
                  children: [
                    futureIndicator("Ibovespa", Api.price("^BVSP", "") , Api.change("^BVSP", "", 3), "^BVSP"),
                    futureIndicator("IBRX", Api.price("IBXX.SA", ""), Api.change("IBXX.SA", "", 3), "IBXX.SA"),
                    futureIndicator("IBX50", Api.price("^IBX50", ""), Api.change("^IBX50", "", 3), "^IBX50"),
                    futureIndicator("S&P500", Api.price("^GSPC", ""), Api.change("^GSPC", "", 3), "^GSPC"),
                  ],
                ),
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
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
              child: Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(5),
                  children: [
                    futureIndicator("Dólar", Api.price("BRL=X", "R\$") , Api.change("BRL=X", "", 3), "BRL=X"),
                    futureIndicator("Euro", Api.price("EURBRL=X", "R\$"), Api.change("EURBRL=X", "", 3), "EURBRL=X"),
                    futureIndicator("Libra", Api.price("GBPBRL=X", "R\$"), Api.change("GBPBRL=X", "", 3), "GBPBRL=X"),
                    futureIndicator("Iene", Api.price("JPYBRL=X", "R\$"), Api.change("JPYBRL=X", "", 3), "JPYBRL=X"),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, top: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Commodities:", style: TextStyle(color: Colors.white, fontSize: 28),)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
              child: Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(5),
                  children: [
                    futureIndicator("Ouro", Api.price("GC=F", "") , Api.change("GC=F", "", 3), "GC=F"),
                    futureIndicator("Petróleo", Api.price("CL=F", ""), Api.change("CL=F", "", 3), "CL=F"),
                    futureIndicator("Milho", Api.price("ZC=F", ""), Api.change("ZC=F", "", 3), "ZC=F"),
                    futureIndicator("Gás Natural", Api.price("NG=F", ""), Api.change("NG=F", "", 3), "NG=F"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget futureIndicator(String indicator, Future<String> value, Future<String> difference, String ticker) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10)
          ),
          height: 125,
          width: 125,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  indicator,
                  style: const TextStyle(color: Colors.white,fontSize: 18),
                ),
                FutureText(text: value, style: const TextStyle(color: Colors.white,fontSize: 20)),
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
      ),
    );
  }
  Widget otherPage(String text, IconData icon){
    return  ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          ),
    );
  }
  Widget appLogo(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Image.asset("assets/images/iconLauncher/icon.png",
        width: 60,
        height: 60,
      ),
    );
  }
}

class FutureText<String> extends StatelessWidget {
  const FutureText({super.key, required this.text, required this.style});

  final Future<String> text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: text,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[Text('${snapshot.data}'.replaceAll(',', '.'), style: style)];
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
  const FutureIcon({super.key, required this.color});

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
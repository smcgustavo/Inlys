import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/StockScreen.dart';
import 'package:inlys/yahooApi.dart';

class StockBlock extends StatefulWidget {
  const StockBlock({super.key, required this.stock});
  final Stock stock;

  @override
  State<StatefulWidget> createState() => StockBlockState();
}

class StockBlockState extends State<StockBlock> {

  @override
  Widget build(BuildContext context) {
    Future<String> price = Api.price("${widget.stock.ticker}F.SA", "R\$");
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  height: 90,
                  width: 100,
                  color: Colors.black.withOpacity(0),
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Center(
                      child: Image(image: widget.stock.logo),
                    ),
                  )),
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder(
                  future: widget.stock.name,
                  builder: (BuildContext context,
                      AsyncSnapshot<String> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ];
                    } else {
                      children = <Widget>[
                        const SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(
                            color: Colors.white,
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
                ),
                Container(
                  width: 230,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 5,
                        height: 7,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),

                      Text(
                        widget.stock.ticker,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),

                      FutureBuilder(
                        future: price,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              Text(
                                '${snapshot.data}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ];
                          } else {
                            children = <Widget>[
                              const SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
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
                      ),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureText(
                            text: Api.change("${widget.stock.ticker}.SA", "", 2),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          FutureIcon(color: Api.color("${widget.stock.ticker}.SA"))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
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
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            splashColor: Colors.white10,
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StockScreen(
                            key: widget.key,
                            stock: widget.stock,
                          )
                  )
              );
            },
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(image: widget.stock.logo),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.stock.ticker,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FutureBuilder(
                            future: Api.price(widget.stock.ticker + "F.SA", "R\$"),
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
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.stock.type,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

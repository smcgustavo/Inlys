import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';

class StockBlock extends StatefulWidget{

  const StockBlock({
    super.key,
    required this.stock
  });
  final Stock stock;

  @override
  State<StatefulWidget> createState() => StockBlockState(stock: stock);
}

class StockBlockState extends State<StockBlock>{

  StockBlockState({
    required this.stock
  });

  final Stock stock;
  @override
  Widget build(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 90,
              color: Colors.white.withOpacity(0.1),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: 90,
                        width: 100,
                        color: Colors.black.withOpacity(0.08),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                              child: Image(image: stock.logo)
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      const SizedBox(height: 15,),
                      FutureBuilder(
                        future: stock.name,
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                          List<Widget> children;
                          if(snapshot.hasData){
                            children = <Widget>[
                              Text(
                                '${snapshot.data}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ];
                          }
                          else{
                            children = <Widget>[
                              const SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(),
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
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            stock.ticker,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                          const SizedBox(width: 5,),
                          FutureBuilder(
                              future: stock.price,
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                                List<Widget> children;
                                if(snapshot.hasData){
                                  children = <Widget>[
                                    Text(
                                        '${snapshot.data}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                    )
                                  ];
                                }
                                else{
                                  children = <Widget>[
                                    const SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: CircularProgressIndicator(),
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
                          const SizedBox(width: 20,),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            stock.type,
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
          )
      );
    }
}
import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/StockScreen.dart';
import 'package:inlys/profile.dart';

class StockBlock extends StatefulWidget{

  const StockBlock({
    super.key,
    required this.stock,
    required this.user
  });
  final Stock stock;
  final Profile user;

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
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StockScreen(key: widget.key, stock: stock, user: widget.user,))
                );
              },
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
                          color: Colors.black.withOpacity(0),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(image: stock.logo),
                                ),
                            ),
                          )
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 70,
                        width: 5,
                        color: Colors.white.withOpacity(0.02),
                      ),
                    ),
                    const SizedBox(width: 15),
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
            ),
          )
      );
    }
}
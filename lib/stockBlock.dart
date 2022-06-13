import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';



class StockBlock extends StatelessWidget{

  const StockBlock({
    super.key,
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
                      color: Colors.white.withOpacity(0.1),
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
                    Text(
                      stock.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              shape: BoxShape.circle
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          stock.ticker,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              shape: BoxShape.circle
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          stock.price,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              shape: BoxShape.circle
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          stock.type,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
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
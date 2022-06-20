import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';

class StockScreen extends StatefulWidget{

  const StockScreen({
    super.key,
    required this.stock
  });

  final Stock stock;

  @override
  State<StatefulWidget> createState() => StockScreenState();
}

class StockScreenState extends State<StockScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: Column(
        children: <Widget> [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 80,
                width: 80,
                color: Colors.white.withOpacity(0.1),
                child: Image(
                  image: widget.stock.logo,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class FutureText<String> extends FutureBuilder{
  const FutureText({
    Key? key,
    required super.builder,
    required this.aux
  });
  final Future<String> aux;

  @override
  Widget build(BuildContext context){
    return Container();
  }

}

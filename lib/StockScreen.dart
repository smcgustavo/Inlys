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
      body: Padding(
        padding:  const EdgeInsets.all(10),
        child: Column(
          children: <Widget> [
            const SizedBox(height: 40,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.white.withOpacity(0.1),
                  child: Image(
                    image: widget.stock.logo,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: FutureText<String>(
                text: widget.stock.name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 20,),
            AttributeBlock(
                  attribute: "Preço: ",
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white
                  ),
                  value: widget.stock.price,
            ),
            const SizedBox(height: 15),
            AttributeBlock(
              attribute: "P/VP: ",
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white
              ),
              value: widget.stock.pvp,
            ),
            const SizedBox(height: 15),
            AttributeBlock(
              attribute: "DY: ",
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white
              ),
              value: widget.stock.dy,
            ),
          ],
        ),
      ),
    );
  }
}

class AttributeBlock extends StatelessWidget{

  final String attribute;
  final TextStyle style;
  final Future<String> value;

  const AttributeBlock({
    Key? key,
    required this.attribute,
    required this.style,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 70,
        color: Colors.white.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(width: 5),
            Text(
              attribute,
              style: style,
            ),
            const SizedBox(width: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 70,
                width: 120,
                color: Colors.white.withOpacity(0.02),
                child: FutureText<String>(
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white
                  ),
                  text: value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class FutureText<String> extends StatelessWidget{
  const FutureText({
    Key? key,
    required this.text,
    required this.style
  });
  final Future<String> text;
  final TextStyle style;
  @override
  Widget build(BuildContext context){
    return
      FutureBuilder(
        future: text,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          List<Widget> children;
          if(snapshot.hasData){
            children = <Widget>[
              Text(
                '${snapshot.data}',
                style: style
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
      );
  }

}

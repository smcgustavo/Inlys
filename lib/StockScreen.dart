import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'dart:math' as math;

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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.rotate(
                  angle: 45 * math.pi / 180,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    color: Colors.white.withOpacity(0.5),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 120,
                      width: 120,
                      color: Colors.white.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image(
                            image: widget.stock.logo,
                          ),
                      ),                      
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Center(
                  child: FutureText<String>(
                    text: widget.stock.name,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 300,
                color: Colors.white.withOpacity(0.05),
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: <Widget> [
                    AttributeBlock(
                      attribute: "Preço: ",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),
                      value: widget.stock.price,
                    ),
                    AttributeBlock(
                      attribute: "P/VP: ",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),
                      value: widget.stock.pvp,
                    ),
                    AttributeBlock(
                      attribute: "DY: ",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),
                      value: widget.stock.dy,
                    ),
                    AttributeBlock(
                      attribute: "ROE: ",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),
                      value: widget.stock.roe,
                    ),

                  ],
                ),
              ),
            )
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
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 50,
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
                    height: 50,
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
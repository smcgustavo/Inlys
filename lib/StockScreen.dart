import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key, required this.stock});

  final Stock stock;

  @override
  State<StatefulWidget> createState() => StockScreenState();
}

class StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  color: Colors.white.withOpacity(0.5),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.white.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image(
                        image: widget.stock.logo,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: FutureText<String>(
                        text: widget.stock.name,
                        style: const TextStyle(
                            fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Colors.white38,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.stock.ticker,
                          style: const TextStyle(
                            color: Colors.white38,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              color: Colors.white38,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.stock.type,
                          style: const TextStyle(
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 50,
                  color: Colors.white.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Índice de Graham:",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      FutureText(
                        text: widget.stock.indicator,
                        style: widget.stock.condition ? const TextStyle(color:Colors.greenAccent, fontSize: 22) : const TextStyle(color:Colors.redAccent, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height: 473,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05)
                    ),
                    child: Scrollbar(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        children: <Widget>[
                          AttributeBlock(
                            attribute: "Preço: ",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            value: widget.stock.price,
                            description: "Preço atual de cada ação.",
                          ),
                          AttributeBlock(
                            attribute: "P/VP: ",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            value: widget.stock.pvp,
                            description: "Valor da ação dividido pelo valor patrimonial por ação. Bom indicador de sobrecompra e sobrevenda.\nQuando menor que 1, sobrevendido.\nQuando maior que 1, sobrecomprado.",
                          ),
                          AttributeBlock(
                            attribute: "DY: ",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            value: widget.stock.dy,
                            description: "Porcentagem do valor da ação distribuído em divivendos anualmente.",
                          ),
                          AttributeBlock(
                            attribute: "ROE: ",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            value: widget.stock.roe,
                            description: "Retorno sobre o patrimônio líquido anual.",
                          ),
                          AttributeBlock(
                            attribute: "P/L: ",
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                            value: widget.stock.pl,
                            description: "P/L é o preço sobre o lucro, um pl alto indica mais anos para se obter o retorno e um pl baixo o contrário.\n"
                                "Ao mesmo tempo que um pl alto indica que investidores pagam alto por aquela empresa e vice e versa.",
                          ),
                        ],
                      ),
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AttributeBlock extends StatelessWidget {
  final String attribute;
  final TextStyle style;
  final Future<String> value;
  final String description;

  const AttributeBlock(
      {super.key,
      required this.attribute,
      required this.style,
      required this.value,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: 
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                ),
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    inkWellBorderRadius: BorderRadius.circular(20),
                    iconColor: Colors.white,
                  ),
                  expanded:  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          description,
                          style: const TextStyle(
                              color: Colors.grey,
                            fontSize: 12
                          ),
                        ),
                      )
                  ),
                  collapsed: const Center(),
                  header: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            attribute,
                            style: style,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Colors.white.withOpacity(0.0),
                              child: FutureText<String>(
                                style: style,
                                text: value,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          )
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
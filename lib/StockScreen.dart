import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/yahooApi.dart';
import 'wallet.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key, required this.stock});
  final Stock stock;

  @override
  State<StatefulWidget> createState() => StockScreenState();
}

class StockScreenState extends State<StockScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: IconButton(
                  color: Colors.white.withOpacity(0.5),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white.withOpacity(0.05),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 120,
                            width: 120,
                            color: Colors.white.withOpacity(0.00),
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
                                Container(
                                  child: ((){
                                    if(Wallet.favoriteStocks.contains(widget.stock)){
                                      return IconButton(
                                          onPressed: (){
                                            setState((){
                                              Wallet.removeStock(widget.stock.ticker);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.turned_in,
                                            color: Colors.grey,
                                          )
                                      );
                                    }
                                    return IconButton(
                                        onPressed: (){
                                          setState((){
                                            Wallet.addStock(widget.stock.ticker);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.turned_in_not,
                                          color: Colors.grey,
                                        )
                                    );
                                  }()
                                  ),
                                )

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            customTabBar(_controller),
            Container(
              height: 500,
              child: TabBarView(controller: _controller, children: [
                fundamentals(),
                stockGraph(),
                DividendCalculator(stock: widget.stock),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget customTabBar(TabController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Container(
          color: Colors.white.withOpacity(0.05),
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
                splashBorderRadius: BorderRadius.circular(10),
                controller: controller,
                labelColor: Colors.white,
                isScrollable: true,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white70,
                labelPadding: const EdgeInsets.only(left: 5, right: 5),
                tabs: const [
                  Tab(
                    text: "Fundamentos",
                  ),
                  Tab(
                    text: "Gráfico",
                  ),
                  Tab(
                    text: "Calculadora de Dividendos",
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget stockGraph() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        child: Container(
          color: Colors.white.withOpacity(0.05),
          child: const Center(
              child: Text(
            "Gráfico Aqui",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }



  Widget fundamentals() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
          child: Scrollbar(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                grahamIndicator(),
                AttributeBlock(
                  attribute: "Preço: ",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  value: Api.price("${widget.stock.ticker}.SA", "R\$"),
                  description: "Preço atual de cada ação.",
                ),
                AttributeBlock(
                  attribute: "P/VP: ",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  value: widget.stock.pvp,
                  description:
                      "Valor da ação dividido pelo valor patrimonial por ação. Bom indicador de sobrecompra e sobrevenda.",
                ),
                AttributeBlock(
                  attribute: "DY: ",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  value: widget.stock.dy,
                  description:
                      "Porcentagem do valor da ação distribuído em divivendos anualmente.",
                ),
                AttributeBlock(
                  attribute: "ROE: ",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  value: widget.stock.roe,
                  description: "Retorno sobre o patrimônio líquido anual.",
                ),
                AttributeBlock(
                  attribute: "P/L: ",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                  value: widget.stock.pl,
                  description:
                      "P/L é o preço sobre o lucro, um pl alto indica mais anos para se obter o retorno e um pl baixo o contrário.\n"
                      "Ao mesmo tempo que um pl alto indica que investidores pagam alto por aquela empresa e vice e versa.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget grahamIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 50,
          color: Colors.white.withOpacity(0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Índice de Graham:",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              FutureText(
                text: widget.stock.indicator,
                style: widget.stock.condition
                    ? const TextStyle(color: Colors.greenAccent, fontSize: 22)
                    : const TextStyle(color: Colors.redAccent, fontSize: 22),
              ),
            ],
          ),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
              ),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  inkWellBorderRadius: BorderRadius.circular(20),
                  iconColor: Colors.white,
                ),
                expanded: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        description,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    )),
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
              )),
        ));
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

class DividendCalculator extends StatefulWidget{

  DividendCalculator({super.key, required this.stock});

  final Stock stock;
  final TextEditingController _formController = TextEditingController();
  String result = "";


  @override
  State<StatefulWidget> createState() => DividendCalculatorState();
}

class DividendCalculatorState extends State<DividendCalculator>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        child: Container(
            color: Colors.white.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              autofocus: false,
                              controller: widget._formController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: "D.Y desejado:",
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    gapPadding: 10,
                                    borderSide: BorderSide(
                                        color: Colors.white70, width: 1.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    gapPadding: 10,
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0)),
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.05),
                              ),
                            child: IconButton(
                                onPressed: () {
                                  setState(() async {
                                    double price = 15;
                                    widget.result = price.toString();
                                  });
                                },
                                icon: const Icon(Icons.done),
                                iconSize: 30,
                                color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children:  [
                            const Text(
                              "Preço sugerido para este D.Y:",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            Text(
                                widget.result,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                          ]
                          ),
                        )
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

}
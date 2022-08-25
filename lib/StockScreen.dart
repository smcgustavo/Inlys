import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/yahooApi.dart';
import 'package:inlys/wallet.dart';
import 'series.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key, required this.stock});
  final Stock stock;

  @override
  State<StatefulWidget> createState() => StockScreenState();
}

class StockScreenState extends State<StockScreen>
    with TickerProviderStateMixin {

  int months = 12;
  double interval = 70.0;
  List<Color> selected = [
    Colors.white.withOpacity(0.10),
    Colors.white.withOpacity(0.00),
    Colors.white.withOpacity(0.00),
    Colors.white.withOpacity(0.00),
  ];

  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
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
                        Container(
                          color: Colors.white.withOpacity(0.00),
                          height: 110,
                          width: 110,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Image(
                              image: widget.stock.logo,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: FutureText<String>(
                                  text: widget.stock.name,
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.white38,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    widget.stock.ticker,
                                    style: const TextStyle(
                                      color: Colors.white38,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                        color: Colors.white38,
                                        shape: BoxShape.circle),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    widget.stock.type,
                                    style: const TextStyle(
                                      color: Colors.white38,
                                    ),
                                  ),
                                  Container(
                                    child: (() {
                                      if (Wallet.stocksString
                                          .contains(widget.stock.ticker)) {
                                        return IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Wallet.removeStock(
                                                    widget.stock.ticker);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.turned_in,
                                              color: Colors.grey,
                                            ));
                                      }
                                      return IconButton(
                                          onPressed: () {
                                            setState(() {
                                              Wallet.addStock(
                                                  widget.stock.ticker);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.turned_in_not,
                                            color: Colors.grey,
                                          ));
                                    }()),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            //customTabBar(controller),
            /*
            Container(
              height: 600,
              child: TabBarView(controller: controller, children: [
                fundamentals(),
                variations(widget.stock),
                stockGraph()
              ]),
            ),*/
            block("Fundamentos", fundamentals(), 400),
            block("Variações", variations(widget.stock), 255),
            block("Gráfico", stockGraph(), 480)
          ],
        ),
      ),
    );
  }

  Widget block(String name, Widget child, double height){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20)
              ),
              height: height,
              child: child,
          ),
        )
      ],
    );
  }

  Widget customTabBar(TabController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
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
                text: "Variações",
              ),
              Tab(
                text: "Gráfico",
              )
            ]),
      ),
    );
  }

  Widget variations(Stock stock) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            variation(
                stock.ticker,
                "Variação diária:",
                Api.change("${stock.ticker}.SA", "R\$ ", 3),
                Api.color("${stock.ticker}.SA")),
            variation(
                stock.ticker,
                "Variação semanal:",
                Api.changeWeek("${stock.ticker}.SA", "R\$ ", 3),
                Api.colorWeek("${stock.ticker}.SA")),
            variation(
                stock.ticker,
                "Variação mensal:",
                Api.changeMonth("${stock.ticker}.SA", "R\$ ", 3),
                Api.colorMonth("${stock.ticker}.SA")),
            variation(
                stock.ticker,
                "Variação anual:",
                Api.changeYear("${stock.ticker}.SA", "R\$ ", 3),
                Api.colorYear("${stock.ticker}.SA")),
          ],
        ),
      ),
    );
  }

  Widget variation(String stockTicker, String description,
      Future<String> change, Future<Color> colorChoosed) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(15)),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              FutureText(
                  text: change,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
              FutureIcon(color: colorChoosed)
            ],
          ),
        ),
      ),
    );
  }

  Widget stockGraph()  {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 15),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: selected[0],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState((){
                          months = 12;
                          interval = 60;
                          selected[0] = Colors.white.withOpacity(0.1);
                          selected[1] = Colors.white.withOpacity(0.0);
                          selected[2] = Colors.white.withOpacity(0.0);
                          selected[3] = Colors.white.withOpacity(0.0);
                        });
                      },
                      child: const Text(
                        "1a",
                        style: TextStyle(color: Colors.white),
                      )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: selected[1],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState((){
                          months = 6;
                          interval = 30;
                          selected[0] = Colors.white.withOpacity(0.0);
                          selected[1] = Colors.white.withOpacity(0.1);
                          selected[2] = Colors.white.withOpacity(0.0);
                          selected[3] = Colors.white.withOpacity(0.0);
                        });
                      },
                      child: const Text(
                        "6m",
                        style: TextStyle(color: Colors.white),
                      )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: selected[2],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState((){
                          months = 3;
                          interval = 15;
                          selected[0] = Colors.white.withOpacity(0.0);
                          selected[1] = Colors.white.withOpacity(0.0);
                          selected[2] = Colors.white.withOpacity(0.1);
                          selected[3] = Colors.white.withOpacity(0.0);
                        });
                      },
                      child: const Text(
                        "3m",
                        style: TextStyle(color: Colors.white),
                      )
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: selected[3],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState((){
                          months = 1;
                          interval = 5;
                          selected[0] = Colors.white.withOpacity(0.0);
                          selected[1] = Colors.white.withOpacity(0.0);
                          selected[2] = Colors.white.withOpacity(0.0);
                          selected[3] = Colors.white.withOpacity(0.1);
                        });
                      },
                      child: const Text(
                        "1m",
                        style: TextStyle(color: Colors.white),
                      )
                  ),
                ),
              ],
            ),
            Graph()
          ],
        ),
      ),
    );
  }

  Widget Graph() {
    return FutureBuilder(
      future: Api.historicalSeries("${widget.stock.ticker}.SA", months),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        List<Widget> children;
        if(snapshot.hasData){
          children = <Widget>[
            SizedBox(
              height: 400,
              width: 400,
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.currency(
                      symbol: "R\$"
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )
              ),
              primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.days,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              interval: interval,
              ),
              series: <ChartSeries>[
                LineSeries<Series, DateTime>(
                  dataSource: snapshot.data,
                  xValueMapper: (Series aux, _) => aux.date,
                  yValueMapper: (Series aux, _) => aux.price,
                )
                ],
              ),
            )
          ];
        }
        else if(snapshot.hasError){
          children = <Widget>[
            Icon(
              Icons.error_outlined,
              color: Colors.white.withOpacity(0.1),
            )
          ];
        }
        else{
          children = <Widget>[
            const SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            )
          ];
        }
        return Center(
          child: Column(
            children: children,
          ),
        );
      },
    );
  }

  Widget fundamentals() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
            AttributeBlock(
              attribute: "VPA: ",
              style: const TextStyle(fontSize: 22, color: Colors.white),
              value: widget.stock.vpa,
              description:
                  "O VPA é o cálculo do valor patrimonial dividido pelo número de ações.",
            ),
            AttributeBlock(
              attribute: "LPA: ",
              style: const TextStyle(fontSize: 22, color: Colors.white),
              value: widget.stock.lpa,
              description:
                  "O LPA é o valor do lucro total dividido pelo número de ações.",
            ),
          ],
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
        }
        else if(snapshot.hasError){
          children = <Widget>[Text("Error", style: style,)];
        }
        else {
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
          if (snapshot.data == Colors.redAccent) {
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
        }
        else if(snapshot.hasError){
          children = <Widget>[
            const Icon(
              Icons.error,
              color: Colors.white60,
            )
          ];
        }
        else {
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

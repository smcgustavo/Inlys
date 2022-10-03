import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:inlys/BackEnd/stock.dart';
import 'package:inlys/BackEnd/yahooApi.dart';
import 'package:inlys/BackEnd/wallet.dart';
import '../BackEnd/series.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' show NumberFormat;

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
                                child:
                                Text(
                                  "${widget.stock.name}",
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
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Ação removida."),
                                                  duration: Duration(seconds: 2),
                                                  backgroundColor: Color.fromRGBO(35, 35, 35, 1),
                                                )
                                              );
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
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Ação adicionada."),
                                                  duration: Duration(seconds: 2),
                                                  backgroundColor: Color.fromRGBO(35, 35, 35, 1),
                                                )
                                            );
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
            block("Fundamentos", fundamentals(), 400),
            block("Variações", variations(widget.stock), 255),
            block("Gráfico", stockGraph(), 490),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget block(String name, Widget child, double height) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 24),
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
                borderRadius: BorderRadius.circular(20)),
            height: height,
            child: child,
          ),
        )
      ],
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
                "Variação Diária:",
                Api.change("${stock.ticker}.SA", "R\$ ", 2),
                Api.color("${stock.ticker}.SA")),
            variation(
                stock.ticker,
                "Variação Semanal:",
                Api.changeWeek("${stock.ticker}.SA", "R\$ ", 2),
                Api.colorWeek("${stock.ticker}.SA")),
            variation(
                stock.ticker,
                "Variação Mensal:",
                Api.changeMonth("${stock.ticker}.SA", "R\$ ", 2),
                Api.colorMonth("${stock.ticker}.SA")),
            variation(
                stock.ticker,
                "Variação Anual:",
                Api.changeYear("${stock.ticker}.SA", "R\$ ", 2),
                Api.colorYear("${stock.ticker}.SA")),
          ],
        ),
      ),
    );
  }

  Widget variation(String stockTicker, String description,
      Future<String> change, Future<Color> colorChoosed) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(15)),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              FutureText(
                  text: change,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: FutureIcon(color: colorChoosed),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget stockGraph() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
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
                        setState(() {
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
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: selected[1],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
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
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: selected[2],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
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
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: selected[3],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
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
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Graph(),
            )
          ],
        ),
      ),
    );
  }

  Widget Graph() {
    return FutureBuilder(
      future: Api.historicalSeries("${widget.stock.ticker}.SA", months),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            SizedBox(
              height: 400,
              width: 400,
              child: SfCartesianChart(
                primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.currency(symbol: "R\$"),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
        } else if (snapshot.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outlined,
              color: Colors.white.withOpacity(0.1),
            )
          ];
        } else {
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
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          children: <Widget>[
            grahamIndicator(),
            AttributeBlock(
              attribute: "Preço: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: Api.price("${widget.stock.ticker}.SA", "R\$"),
              description: "Preço atual de cada ação.",
            ),
            BlockAttribute(
              attribute: "P/VP: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: "${widget.stock.pvp}".replaceAll(',', '.').replaceAll('nan', '0'),
              description:
                  "Valor da ação dividido pelo valor patrimonial por ação. Bom indicador de sobrecompra e sobrevenda.",
            ),
            BlockAttribute(
              attribute: "DY: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: "${widget.stock.dy}%".replaceAll(',', '.').replaceAll('nan', '0'),
              description:
                  "Porcentagem do valor da ação distribuído em divivendos anualmente.",
            ),
            BlockAttribute(
              attribute: "ROE: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: "${widget.stock.roe}".replaceAll(',', '.').replaceAll('nan', '0'),
              description: "Retorno sobre o patrimônio líquido anual.",
            ),
            BlockAttribute(
              attribute: "P/L: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: "${widget.stock.pl}".replaceAll(',', '.').replaceAll('nan', '0'),
              description:
                  "P/L é o preço sobre o lucro, um pl alto indica mais anos para se obter o retorno e um pl baixo o contrário.\n"
                  "Ao mesmo tempo que um pl alto indica que investidores pagam alto por aquela empresa e vice e versa.",
            ),
            AttributeBlock(
              attribute: "VPA: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: widget.stock.vpa,
              description:
                  "O VPA é o cálculo do valor patrimonial dividido pelo número de ações.",
            ),
            AttributeBlock(
              attribute: "LPA: ",
              style: const TextStyle(fontSize: 20, color: Colors.white),
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20)
        ),
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            inkWellBorderRadius: BorderRadius.circular(20),
            iconColor: Colors.white,
          ),
          expanded: const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Cálculo do preço justo de uma ação, utiliza o VPA e o LPA.\nFórmula: Raíz(22,5 X VPA X LPA)\nIndisponível quando o VPA ou LPA são negativos.",
                  style:
                  TextStyle(color: Colors.grey, fontSize: 12),
                ),
              )
          ),
          collapsed: const SizedBox(),
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Índice de Graham:",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                FutureText(
                    text: widget.stock.indicator,
                    style: widget.stock.condition
                        ? const TextStyle(color: Colors.greenAccent, fontSize: 20)
                        : const TextStyle(color: Colors.redAccent, fontSize: 20),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

class AttributeBlock extends StatelessWidget {
  final String attribute;
  final TextStyle style;
  final Future<String?> value;
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
                collapsed: const SizedBox(),
                header: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            attribute,
                            style: style,
                          ),
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

class BlockAttribute extends StatelessWidget {
  final String attribute;
  final TextStyle style;
  final String? value;
  final String description;

  const BlockAttribute({super.key, required this.attribute, required this.style, required this.value, required this.description});

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
                collapsed: const SizedBox(),
                header: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            attribute,
                            style: style,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.white.withOpacity(0.0),
                            child: Text(
                              "$value",
                              style: style,
                            )
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
  const FutureText({super.key, required this.text, required this.style});

  final Future<String?> text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: text,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[Text('${snapshot.data}'.replaceAll(',', '.').replaceAll('nan', '0') , style: style)];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Text(
              "Error",
              style: style,
            )
          ];
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

class FutureIcon<String> extends StatelessWidget {
  const FutureIcon({super.key, required this.color});
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
          } else {
            children = <Widget>[
              Icon(
                Icons.trending_up,
                color: snapshot.data,
              )
            ];
          }
        } else if (snapshot.hasError) {
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

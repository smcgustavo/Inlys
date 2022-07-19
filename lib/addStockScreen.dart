import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/stockBlock.dart';
import 'package:inlys/StockScreen.dart';

List<String> allStocks = [
  "BBAS3",
  "PETR4",
  "GOLL4",
  "BIDI4",
  "BBDC4",
  "ITUB4",
  "ABEV3",
  "VALE3",
  "MGLU3",
];

class SearchStock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchStockState();
}

class SearchStockState extends State<SearchStock> {

  List<String> stocks = allStocks;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: controller,
              onChanged: searchStock,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                hintText: 'Pesquise o papel:',
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white70)),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gapPadding: 10,
                    borderSide: BorderSide(color: Colors.white70, width: 1.0)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gapPadding: 10,
                    borderSide: BorderSide(color: Colors.white, width: 1.0)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final stock = stocks[index].toUpperCase();
                    return listItem(Stock(stock));
                  },
                  itemCount: stocks.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchStock(String query) {
    List<String> result = [];
    final input = query.toLowerCase();
    for (var stock in allStocks) {
      if (stock.toLowerCase().contains(input)) {
        result.add(stock.toUpperCase());
      }
    }
    setState(() => stocks = result);
  }

  Widget listItem(Stock stock) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListTile(
        leading:
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 120,
            width: 90,
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image(
                image: stock.logo,
              ),
            ),
          ),
        ),
        title: Text(
          stock.ticker,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => StockScreen(
                  stock: stock
              ),
            )
        ),
      ),
    );
  }
}

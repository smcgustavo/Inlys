import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/StockScreen.dart';

class SearchStock extends StatefulWidget {
  SearchStock({super.key, required this.allStocks});
  List<String> allStocks;
  @override
  State<StatefulWidget> createState() => SearchStockState(stocks: allStocks);
}

class SearchStockState extends State<SearchStock> {

  SearchStockState({required this.stocks});
  List<String> stocks;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            TextFormField(
              style: const TextStyle(color: Colors.white),
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
                    final stock = stocks[index];
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
    final input = query.toUpperCase();
    for (var stock in widget.allStocks) {
      if (stock.contains(input)) {
        result.add(stock.toUpperCase());
      }
    }
    setState(() => stocks = result);
  }

  Widget listItem(Stock stock) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            title: Center(
              child: Text(
                stock.ticker,
                style: const TextStyle(
                    color: Colors.white
                ),
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
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:inlys/BackEnd/stock.dart';
import 'package:inlys/Widgets/StockScreen.dart';
import 'package:inlys/BackEnd/stocksList.dart';

class SearchStock extends StatefulWidget {
  const SearchStock({super.key});
  @override
  State<StatefulWidget> createState() => SearchStockState();
}

class SearchStockState extends State<SearchStock> {
  List<String> stocks = allStocks;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white70,
            )
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            onChanged: searchStock,
            decoration: InputDecoration(
              hintText: 'Pesquise o papel:',
              hintStyle: const TextStyle(color: Colors.white70),
              suffixIcon: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    setState(() {
                      controller.text = "";
                      searchStock("");
                    });
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white70,
                  )
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0))),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gapPadding: 10,
                  borderSide:
                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0), width: 1.0)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gapPadding: 10,
                  borderSide:
                  BorderSide(color: Color.fromRGBO(0, 0, 0, 0), width: 1.0)),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: (() {
                if (stocks.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhum papel encontrado.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final stock = Stock(stocks[index]);
                    return listItem(stock);
                  },
                  itemCount: stocks.length,
                );
              }()),
            ),
          )
        ],
      ),
    );
  }

  void searchStock(String query) {
    List<String> result = [];
    final input = query.toUpperCase();
    for (var stock in allStocks) {
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
                  borderRadius: BorderRadius.circular(20)),
              title: Center(
                child: Text(
                  stock.ticker,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockScreen(stock: stock),
                  )),
            ),
          )),
    );
  }
}

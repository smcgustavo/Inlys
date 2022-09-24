import 'package:flutter/material.dart';
import 'package:inlys/stockBlock.dart';
import 'package:inlys/wallet.dart';
import 'package:inlys/addStockScreen.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/StockScreen.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({Key? key, required this.allStocks}) : super(key: key);
  List<String> allStocks;
  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver {

  List<Stock> stocks = Wallet.getWallet();

  @override
  void didPop(){
    setState((){
      stocks = Wallet.getWallet();
    });
  }

  @override
  Widget build(BuildContext context) {
    SearchStock(allStocks: widget.allStocks);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        elevation: 0,
        title: const Text("Carteira:",
          style: TextStyle(
              color: Colors.white,
              fontSize: 26
          ),
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
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
                      "Carteira vazia.",
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: stocks.length,
                  itemBuilder: (context, index) {
                    final StockBlock aux = StockBlock(stock: stocks[index]);
                    return
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StockScreen(
                                      key: widget.key,
                                      stock: stocks[index],
                                    )
                                )
                            ).then((_) => setState(() {}));
                          },
                          child: aux,
                        ),
                      );
                  },
                );
              }())
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchStock(allStocks: widget.allStocks),
              )).then((_) => setState(() {}));
        },
        backgroundColor: Colors.black87,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

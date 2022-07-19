import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/stockBlock.dart';

class SearchStock extends StatelessWidget {
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
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: Colors.white70,),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.white70,),
                    hintText: 'Pesquise o papel:',
                    hintStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white70)
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gapPadding: 10,
                        borderSide: BorderSide(color: Colors.white70, width: 1.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gapPadding: 10,
                        borderSide: BorderSide(color: Colors.white, width: 1.0)),
                  ),
                )
              ],
            ),
        ),
        );
  }
}

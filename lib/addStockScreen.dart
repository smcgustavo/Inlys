import 'package:flutter/material.dart';
import 'package:inlys/stock.dart';
import 'package:inlys/stockBlock.dart';

class SearchStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
        body: Column(
            children: [
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
        );
  }
}



/*Container(
              width: 300,
              height: 75,
              child: const TextField(
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.9)),
                decoration: InputDecoration(
                  hintText: 'Papel da Ação',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.6)
                  ),
                  suffixIcon: Icon(Icons.search, color: Color.fromRGBO(255, 255, 255, 0.6),),
                  contentPadding:  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  labelStyle:  TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
                  enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gapPadding: 10,
                      borderSide: BorderSide(color: Colors.white70, width: 1.0)),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gapPadding: 10,
                      borderSide: BorderSide(color: Colors.white, width: 1.0)),
                ),
              ),
),*/

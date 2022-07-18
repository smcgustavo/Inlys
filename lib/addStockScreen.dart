import 'package:flutter/material.dart';

class SearchStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      body: 
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white.withOpacity(0.5),
                  )
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 300,
              height: 200,
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
            ),
          ],
        ),
      )
    );
  }
  
}
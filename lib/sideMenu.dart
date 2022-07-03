import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget{

  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: const <Widget> [
                  SizedBox(height: 30),
                  Image(
                    image: AssetImage(
                      'assets/images/profile.png',
                    ),
                    width: 50,
                    height: 50,
                  )
                ],
              ),
            )
        ],
      ),
    ),
  );

}
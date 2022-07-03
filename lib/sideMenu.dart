import 'package:flutter/material.dart';
import 'package:inlys/profile.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);
  final Profile user = Profile("Gustavo");
  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Image(
                      image: AssetImage(
                        'assets/images/profile.png',
                      ),
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Olá, ${user.name}",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
              ),
              const Form(
                fieldName: "Selic",
                fieldText: "Digite o valor da taxa Selic",
              )
            ],
          ),
        ),
      );
}

class Form extends StatelessWidget {
  final String fieldName, fieldText;
  const Form({Key? key, required this.fieldName, required this.fieldText});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                fieldName,
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle:
                  const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      gapPadding: 10,
                      borderSide: BorderSide(color: Colors.white, width: 1.0)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      gapPadding: 10,
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0)),
                  labelText: fieldText,
                ),
              ),
          ),
          
        ],
      ),
    );
  }
}

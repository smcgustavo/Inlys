import 'package:flutter/material.dart';
import 'package:inlys/profile.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);
  final Profile user = Profile("Gustavo", 13.25);
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
              const SizedBox(height: 20,),
              Form(
                fieldName: "Selic:",
                fieldText: user.selic.toString(),
                user: user,
              )
            ],
          ),
        ),
      );
}

class Form extends StatelessWidget {
  final String fieldName, fieldText;
  final Profile user;
  Form({Key? key, required this.fieldName, required this.fieldText, required this.user}) : super(key: key);
  final TextEditingController _formController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white.withOpacity(0.05),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  fieldName,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,bottom: 10, left: 15, top: 10),
              child: Container(
                width: 150,
                child: TextFormField(
                  controller: _formController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gapPadding: 10,
                        borderSide: BorderSide(color: Colors.white, width: 1.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        gapPadding: 10,
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1.0)),
                    labelText: fieldText,
                  ),
                ),
              )
            ),
            IconButton(
                onPressed: (){
                  user.setSelic(double.parse(_formController.text));
                },
                icon: const Icon(Icons.save),
                color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

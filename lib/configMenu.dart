import 'package:flutter/material.dart';
import 'package:inlys/profile.dart';

class ConfigMenu extends StatefulWidget {
  ConfigMenu({Key? key}) : super(key: key);
  final Profile user = Profile("Gustavo", 13.25);

  @override
  State<StatefulWidget> createState() => ConfigMenuState();
}

class ConfigMenuState extends State<ConfigMenu>{
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                    "Olá, ${widget.user.name}",
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Form(
              fieldName: "Selic:",
              fieldText: widget.user.selic.toString(),
              user: widget.user,
            )
          ],
        ),
      )
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                width: 200,
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
                  user.setSelic(double.parse(_formController.text.replaceAll(",", ".")));
                  FocusScope.of(context).unfocus();
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

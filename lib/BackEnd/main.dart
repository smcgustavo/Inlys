import 'package:flutter/material.dart';
import 'package:inlys/BackEnd/csvManager.dart';
import 'package:inlys/BackEnd/wallet.dart';
import '../Widgets/homeScreen.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Wallet.initializeWallet();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final DataManager manager = DataManager();
    manager.loadAsset();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen()
    );
  }
}
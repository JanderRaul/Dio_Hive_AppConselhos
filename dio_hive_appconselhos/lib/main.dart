import 'package:dio_hive_appconselhos/configs/hive_config.dart';
import 'package:dio_hive_appconselhos/repository/favoritas_repository.dart';
import 'package:dio_hive_appconselhos/views/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(ChangeNotifierProvider(
    create: (context) => FavoritasRepository(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conselhos',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

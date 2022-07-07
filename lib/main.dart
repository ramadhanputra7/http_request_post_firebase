import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/add_player_page.dart';
import 'pages/detail_player_page.dart';
import 'pages/home_page.dart';
import 'providers/players.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Players(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          AddPlayer.routeName: (context) => AddPlayer(),
          DetailPlayer.routeName: (context) => DetailPlayer(),
        },
      ),
    );
  }
}

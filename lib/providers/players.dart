import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../models/player.dart';

class Players with ChangeNotifier {
  List<Player> _allPlayer = [];
  List<Player> get allPlayer => _allPlayer;

  int get jumlahPlayer => _allPlayer.length;

  Player selectById(String id) =>
      _allPlayer.firstWhere((element) => element.id == id);

  Future<void> addPlayer(String name, String position, String image) {
    DateTime dateTimeNow = DateTime.now();

    Uri url = Uri.parse(
        "https://httprequest-af75a-default-rtdb.firebaseio.com/players.json");
    return http
        .post(
      url,
      body: json.encode(
        {
          "name": name,
          "position": position,
          "imageUrl": image,
          "createdAt": dateTimeNow.toString(),
        },
      ),
    )
        .then((response) {
      print("THEN FUNCTION");
      _allPlayer.add(
        Player(
          id: json.decode(response.body)["name"].toString(),
          name: name,
          position: position,
          imageUrl: image,
          createdAt: dateTimeNow,
        ),
      );
      notifyListeners();
    });
  }

  void editPlayer(String id, String name, String position, String image,
      BuildContext context) {
    Player selectPlayer = _allPlayer.firstWhere((element) => element.id == id);
    selectPlayer.name = name;
    selectPlayer.position = position;
    selectPlayer.imageUrl = image;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil Diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deletePlayer(String id, BuildContext context) {
    _allPlayer.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Berhasil Dihapus"),
      duration: Duration(seconds: 2),
    ));
    notifyListeners();
  }
}
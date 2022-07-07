import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/players.dart';

class DetailPlayer extends StatelessWidget {
  static const routeName = "/detail-player";
  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Players>(context, listen: false);
    final playerId = ModalRoute.of(context)?.settings.arguments as String;
    final selectPlayer = players.selectById(playerId);
    final TextEditingController imageController =
        TextEditingController(text: selectPlayer.imageUrl);
    final TextEditingController nameController =
        TextEditingController(text: selectPlayer.name);
    final TextEditingController positionController =
        TextEditingController(text: selectPlayer.position);
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAIL PLAYER"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageController.text),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Nama"),
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(labelText: "Posisi"),
                  textInputAction: TextInputAction.next,
                  controller: positionController,
                ),
                TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(labelText: "Image URL"),
                    textInputAction: TextInputAction.done,
                    controller: imageController,
                    onEditingComplete: () {
                      players.editPlayer(
                        playerId,
                        nameController.text,
                        positionController.text,
                        imageController.text,
                        context,
                      );
                      Navigator.pop(context);
                    }),
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {
                        players.editPlayer(
                          playerId,
                          nameController.text,
                          positionController.text,
                          imageController.text,
                          context,
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

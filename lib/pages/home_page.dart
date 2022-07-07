import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/players.dart';
import 'add_player_page.dart';
import 'detail_player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPlayerProvider = Provider.of<Players>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("ALL PLAYERS"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddPlayer.routeName);
              },
            )
          ],
        ),
        body: (allPlayerProvider.jumlahPlayer == 0)
            ? Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Data",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddPlayer.routeName);
                      },
                      child: Text("Add Player", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ))
            : ListView.builder(
                itemCount: allPlayerProvider.jumlahPlayer,
                itemBuilder: (context, index) {
                  var id = allPlayerProvider.allPlayer[index].id;
                  return Padding(
                    padding: const EdgeInsets.all(29.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailPlayer.routeName,
                          arguments: id,
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          allPlayerProvider.allPlayer[index].imageUrl,
                        ),
                      ),
                      title: Text(
                        allPlayerProvider.allPlayer[index].name,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(
                            allPlayerProvider.allPlayer[index].createdAt),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          allPlayerProvider.deletePlayer(id, context);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ));
  }
}

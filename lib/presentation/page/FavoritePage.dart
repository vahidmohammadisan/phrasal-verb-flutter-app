import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/constants.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  List<String> favList = [];

  void loadFav() async {
    favList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //setState(() {
      favList = prefs.getStringList('fav')!;
    //});
  }

  void addFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //setState(() {
      prefs.setStringList('fav', favList);
    //});
  }

  @override
  void initState() {
    super.initState();
    loadFav();
  }

  getUrl(String link) {
    String l = Urls.imageUrl;
    String ll = link.split("/")[5].toString();
    String lll = ll.split("/")[0].toString();
    return '$l$lll';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Phrasal Verbs",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: favList.length.toInt(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        //dismissible:
                        //    DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) => {
                              favList.removeAt(index),
                              addFav(),
                            },
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        //dense: false,
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              elevation: 10,
                              shape: const Border(
                                  right: BorderSide(
                                      color: Colors.purple, width: 8)),
                              child: CachedNetworkImage(
                                imageUrl: getUrl(favList[index].toString()),
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.purple),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}

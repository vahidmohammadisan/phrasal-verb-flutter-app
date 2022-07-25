import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phrasalverbs/data/constants.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseBloc.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseEvent.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseState.dart';
import 'package:phrasalverbs/presentation/page/FavoritePage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int page = 5;

  final ScrollController _controller = ScrollController();
  final double _height = 100.0;
  List<String> favList = [];

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  getUrl(String link) {
    String l = Urls.imageUrl;
    String ll = link.split("/")[5].toString();
    String lll = ll.split("/")[0].toString();
    return '$l$lll';
  }

  void addFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('fav', favList);
    });
  }

  void loadFav() async {
    favList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favList = prefs.getStringList('fav')!;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFav();
  }

  @override
  Widget build(BuildContext context) {
    if (page == 5) context.read<PhraseBloc>().add(const GetPhrase());
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Phrasal Verbs",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoritePage()),
                      )
                    },
                child: const Text(
                  "favorite",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ],
        ),
        BlocBuilder<PhraseBloc, PhraseState>(builder: (context, state) {
          if (state is PhraseLoading) {
            return Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                LoadingAnimationWidget.inkDrop(color: Colors.purple, size: 50)
              ],
            ));
          } else if (state is PhraseData) {
            _animateToIndex(page * 5);
            return Expanded(
              child: ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: page,
                  itemBuilder: (context, position) {
                    return state.phrase.body.isEmpty
                        ? const Center(child: Text('Oops!, No Result Found.'))
                        : Column(
                            children: [
                              Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  //dismissible:
                                  //    DismissiblePane(onDismissed: () {}),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) => {
                                        Share.share(
                                            state.phrase.body[position].link)
                                      },
                                      backgroundColor: Colors.purple,
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext context) => {
                                        loadFav(),
                                        favList.add(
                                            state.phrase.body[position].link),
                                        addFav(),
                                      },
                                      backgroundColor: Colors.blueAccent,
                                      foregroundColor: Colors.white,
                                      icon: Icons.save,
                                      label: 'Save',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  //dense: false,
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Card(
                                        elevation: 10,
                                        shape: const Border(
                                            right: BorderSide(
                                                color: Colors.purple,
                                                width: 8)),
                                        child: CachedNetworkImage(
                                          imageUrl: getUrl(
                                              state.phrase.body[position].link),
                                          placeholder: (context, url) =>
                                              const LinearProgressIndicator(
                                            backgroundColor:
                                                Colors.white,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
                              SizedBox(
                                height: 1.5,
                                child: Container(color: Colors.black12),
                              ),
                            ],
                          );
                  }),
            );
          } else {
            return const Center();
          }
        }),
        FloatingActionButton(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          onPressed: () => {
            setState(() {
              page += 5;
            })
          },
          child: const Icon(Icons.sync),
        )
      ],
    )));
  }
}

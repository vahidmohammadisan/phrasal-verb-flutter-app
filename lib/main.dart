import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseBloc.dart';
import 'package:phrasalverbs/presentation/page/MainPage.dart';

import 'di.dart' as di;

void main() {
  di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.purpleAccent));

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<PhraseBloc>(),
          )
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Phrasal Verbs",
          home: MainPage(),
        ));
  }
}

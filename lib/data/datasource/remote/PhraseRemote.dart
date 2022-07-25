import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:phrasalverbs/data/model/PhraseModel.dart';

import '../../constants.dart';
import '../../exception.dart';

abstract class RemoteDataSource {
  Future<PhraseModel> getPhrase();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl();

  @override
  Future<PhraseModel> getPhrase() async {
    final response = await http.get(Uri.parse(Urls.baseUrl));
    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List<Model> listModel = [];
      for(Map i in data){
        listModel.add(Model.fromJson(i));
      }

      return PhraseModel(body: listModel);
    } else {
      throw ServerException();
    }
  }
}

import 'package:equatable/equatable.dart';

class PhraseModel extends Equatable {
  PhraseModel({required this.body});

  final List<Model> body;

  @override
  // TODO: implement props
  List<Object> get props => [body];
}

class Model {

  String name;
  String link;

  Model({
    required this.name,
    required this.link,
  });

  factory Model.fromMap(Map<String, dynamic> map) => Model(
      name: map['name'],
      link: map['link']);

  factory Model.fromJson(Map<dynamic, dynamic> json) =>
      Model(
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "link": link,
      };
}

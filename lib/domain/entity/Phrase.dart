import 'package:equatable/equatable.dart';

class Phrase extends Equatable {
  const Phrase({required this.Name, required this.Link});

  final String Name;
  final String Link;

  @override
  // TODO: implement props
  List<Object> get props => [Name, Link];
}

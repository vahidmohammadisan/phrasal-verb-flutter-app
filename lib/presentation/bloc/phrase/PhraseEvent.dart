import 'package:equatable/equatable.dart';

abstract class PhraseEvent extends Equatable {
  const PhraseEvent();

  @override
  List<Object> get props => [];
}

class GetPhrase extends PhraseEvent {
  const GetPhrase();

  @override
  List<Object> get props => [];
}

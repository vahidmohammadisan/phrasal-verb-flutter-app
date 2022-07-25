import 'package:equatable/equatable.dart';
import 'package:phrasalverbs/data/model/PhraseModel.dart';

abstract class PhraseState extends Equatable {
  const PhraseState();

  @override
  List<Object> get props => [];
}

class PhraseEmpty extends PhraseState {}

class PhraseLoading extends PhraseState {}

class PhraseError extends PhraseState {
  final String message;

  const PhraseError(this.message);

  @override
  List<Object> get props => [message];
}

class PhraseData extends PhraseState {
  final PhraseModel phrase;

  const PhraseData(this.phrase);

  @override
  List<Object> get props => [phrase];
}

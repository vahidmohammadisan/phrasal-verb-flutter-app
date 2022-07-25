import 'package:dartz/dartz.dart';
import 'package:phrasalverbs/data/model/PhraseModel.dart';
import 'package:phrasalverbs/domain/repository/PhraseRepository.dart';

import '../../data/failure.dart';

class FetchPhraseUseCase {
  final PhraseRepository phraseRepository;

  FetchPhraseUseCase(this.phraseRepository);

  Future<Either<Failure, PhraseModel>> execute() =>
      phraseRepository.getPhrase();
}

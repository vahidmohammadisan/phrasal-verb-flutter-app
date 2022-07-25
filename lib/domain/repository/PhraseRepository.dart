import 'package:dartz/dartz.dart';
import 'package:phrasalverbs/data/model/PhraseModel.dart';

import '../../data/failure.dart';

abstract class PhraseRepository {
  Future<Either<Failure, PhraseModel>> getPhrase();
}

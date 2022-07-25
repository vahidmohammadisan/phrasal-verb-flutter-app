import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:phrasalverbs/data/model/PhraseModel.dart';
import 'package:phrasalverbs/domain/repository/PhraseRepository.dart';

import '../datasource/remote/PhraseRemote.dart';
import '../exception.dart';
import '../failure.dart';

class PhraseRepositoryImpl implements PhraseRepository {
  PhraseRepositoryImpl(
      {required this.remoteDataSource});

  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, PhraseModel>> getPhrase() async {
    try {
      final result = await remoteDataSource.getPhrase();
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure('connection failure'));
    } on ServerException {
      return const Left(ServerFailure('server failure'));
    }
  }
}

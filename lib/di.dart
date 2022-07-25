import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:phrasalverbs/data/repository/PhraseRepositoryImpl.dart';
import 'package:phrasalverbs/domain/repository/PhraseRepository.dart';
import 'package:phrasalverbs/domain/usecase/FetchPhraseUseCase.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseBloc.dart';

import 'data/datasource/remote/PhraseRemote.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory<PhraseBloc>(() => PhraseBloc(locator()));

  //usecase
  locator.registerLazySingleton<FetchPhraseUseCase>(
      () => FetchPhraseUseCase(locator()));

  //repository
  locator.registerLazySingleton<PhraseRepository>(
      () => PhraseRepositoryImpl(remoteDataSource: locator()));

  //data source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

  locator.registerLazySingleton(() => http.Client);
}

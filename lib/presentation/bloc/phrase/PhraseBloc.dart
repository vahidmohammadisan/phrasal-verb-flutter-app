import 'package:bloc/bloc.dart';
import 'package:phrasalverbs/domain/usecase/FetchPhraseUseCase.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseEvent.dart';
import 'package:phrasalverbs/presentation/bloc/phrase/PhraseState.dart';
import 'package:rxdart/rxdart.dart';

class PhraseBloc extends Bloc<PhraseEvent, PhraseState> {
  final FetchPhraseUseCase _getPhrases;

  PhraseBloc(this._getPhrases) : super(PhraseEmpty()) {
    on<GetPhrase>(
      (event, emit) async {
        emit(PhraseLoading());

        final result = await _getPhrases.execute();
        result.fold((failure) => emit(PhraseError(failure.message)),
            (data) => emit(PhraseData(data)));
      },
      transformer: debounce(const Duration(milliseconds: 1500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

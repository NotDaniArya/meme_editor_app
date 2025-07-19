import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_editor_app/core/usecase/usecase.dart';
import 'package:meme_editor_app/features/meme/domain/usecases/get_memes_usecase.dart';

import '../../domain/entities/meme.dart';

abstract class MemeState {}

class MemeInitial extends MemeState {}

class MemeLoading extends MemeState {}

class MemeLoaded extends MemeState {
  final List<Meme> memes;

  MemeLoaded(this.memes);
}

class MemeError extends MemeState {
  final String message;

  MemeError(this.message);
}

class MemeNotifier extends StateNotifier<MemeState> {
  final GetMemesUseCase getMemesUseCase;

  MemeNotifier({required this.getMemesUseCase}) : super(MemeInitial());

  Future<void> fetchMemes() async {
    state = MemeLoading();
    final result = await getMemesUseCase(NoParams());
    result.fold(
      (failure) => state = MemeError(failure.message),
      (memes) => state = MemeLoaded(memes),
    );
  }
}

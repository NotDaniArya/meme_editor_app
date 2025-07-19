import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:meme_editor_app/features/meme/data/datasources/meme_remote_data_source.dart';
import 'package:meme_editor_app/features/meme/data/repositories/meme_repository_impl.dart';
import 'package:meme_editor_app/features/meme/domain/repositories/meme_repository.dart';
import 'package:meme_editor_app/features/meme/domain/usecases/get_memes_usecase.dart';

import '../notifiers/meme_notifier.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final remoteDataSourceProvider = Provider<MemeRemoteDataSource>(
  (ref) => MemeRemoteDataSourceImpl(client: ref.watch(httpClientProvider)),
);

final memeRepositoryProvider = Provider<MemeRepository>(
  (ref) =>
      MemeRepositoryImpl(remoteDataSource: ref.watch(remoteDataSourceProvider)),
);

final getMemesUseCaseProvider = Provider<GetMemesUseCase>(
  (ref) => GetMemesUseCase(ref.watch(memeRepositoryProvider)),
);

final memeNotifierProvider = StateNotifierProvider<MemeNotifier, MemeState>((
  ref,
) {
  return MemeNotifier(getMemesUseCase: ref.watch(getMemesUseCaseProvider));
});

import 'package:dartz/dartz.dart';
import 'package:meme_editor_app/core/error/failures.dart';
import 'package:meme_editor_app/core/usecase/usecase.dart';
import 'package:meme_editor_app/features/meme/domain/entities/meme.dart';
import 'package:meme_editor_app/features/meme/domain/repositories/meme_repository.dart';

class GetMemesUseCase implements UseCase<List<Meme>, NoParams> {
  final MemeRepository repository;

  GetMemesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Meme>>> call(NoParams params) async {
    return await repository.getMemes();
  }
}

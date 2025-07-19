import 'package:dartz/dartz.dart';
import 'package:meme_editor_app/core/error/failures.dart';
import 'package:meme_editor_app/features/meme/domain/entities/meme.dart';

abstract class MemeRepository {
  Future<Either<Failure, List<Meme>>> getMemes();
}

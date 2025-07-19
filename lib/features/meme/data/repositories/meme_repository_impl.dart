import 'package:dartz/dartz.dart';
import 'package:meme_editor_app/core/error/exceptions.dart';
import 'package:meme_editor_app/core/error/failures.dart';
import 'package:meme_editor_app/features/meme/data/datasources/meme_remote_data_source.dart';
import 'package:meme_editor_app/features/meme/domain/entities/meme.dart';
import 'package:meme_editor_app/features/meme/domain/repositories/meme_repository.dart';

class MemeRepositoryImpl implements MemeRepository {
  final MemeRemoteDataSource remoteDataSource;

  const MemeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Meme>>> getMemes() async {
    try {
      final remoteMemes = await remoteDataSource.getMemes();
      return Right(remoteMemes);
    } on ServerException {
      return const Left(ServerFailure('Gagal mengambil data dari server'));
    }
  }
}

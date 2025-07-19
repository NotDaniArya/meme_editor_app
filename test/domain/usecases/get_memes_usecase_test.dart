import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme_editor_app/core/usecase/usecase.dart';
import 'package:meme_editor_app/features/meme/domain/entities/meme.dart';
import 'package:meme_editor_app/features/meme/domain/repositories/meme_repository.dart';
import 'package:meme_editor_app/features/meme/domain/usecases/get_memes_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_memes_usecase_test.mocks.dart';

// Anotasi untuk generate mock class
@GenerateMocks([MemeRepository])
void main() {
  late GetMemesUseCase useCase;
  late MockMemeRepository mockMemeRepository;

  setUp(() {
    mockMemeRepository = MockMemeRepository();
    useCase = GetMemesUseCase(mockMemeRepository);
  });

  final tMemeList = [
    const Meme(id: '1', name: 'Test Meme 1', url: 'url1.jpg'),
    const Meme(id: '2', name: 'Test Meme 2', url: 'url2.jpg'),
  ];

  test('should get list of memes from the repository', () async {
    // Arrange: atur kondisi mock
    when(
      mockMemeRepository.getMemes(),
    ).thenAnswer((_) async => Right(tMemeList));

    // Act: panggil use case
    final result = await useCase(NoParams());

    // Assert: pastikan hasilnya sesuai harapan
    expect(result, Right(tMemeList));
    verify(mockMemeRepository.getMemes());
    verifyNoMoreInteractions(mockMemeRepository);
  });
}

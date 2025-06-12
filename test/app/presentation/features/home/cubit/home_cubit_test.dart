import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/app/data/models/post_model.dart';
import 'package:news_app/app/data/repositories/post_repository.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_cubit.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_state.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late HomeCubit homeCubit;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    homeCubit = HomeCubit(mockPostRepository);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit', () {
    test('initial state is HomeInitial', () {
      expect(homeCubit.state, const HomeInitial());
    });

    test('emits [HomeLoading, HomeSuccess] when posts are fetched successfully',
        () async {
      final posts = [
        PostModel(
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
          userId: 1,
        ),
      ];

      when(() => mockPostRepository.getPosts()).thenAnswer((_) async => posts);

      final expectedStates = [
        const HomeLoading(),
        HomeSuccess(posts),
      ];

      expectLater(homeCubit.stream, emitsInOrder(expectedStates));

      await homeCubit.fetchPosts();
    });

    test('emits [HomeLoading, HomeError] when posts fetch fails', () async {
      final error = Exception('Failed to fetch posts');

      when(() => mockPostRepository.getPosts()).thenThrow(error);

      final expectedStates = [
        const HomeLoading(),
        HomeError(error.toString()),
      ];

      expectLater(homeCubit.stream, emitsInOrder(expectedStates));

      await homeCubit.fetchPosts();
    });
  });
}

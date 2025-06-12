import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/app/data/models/post_model.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_cubit.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_state.dart';
import 'package:news_app/app/presentation/features/home/view/home_screen.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  late MockHomeCubit mockHomeCubit;

  setUpAll(() {
    registerFallbackValue(const HomeInitial());
  });

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    when(() => mockHomeCubit.fetchPosts()).thenAnswer((_) async {});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<HomeCubit>.value(
        value: mockHomeCubit,
        child: const HomeView(),
      ),
    );
  }

  group('HomeScreen', () {
    testWidgets('shows loading indicator when state is loading',
        (WidgetTester tester) async {
      when(() => mockHomeCubit.state).thenReturn(const HomeLoading());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Loading posts...'), findsOneWidget);
    });

    testWidgets('shows error view when state is error',
        (WidgetTester tester) async {
      const errorMessage = 'Test error message';
      when(() => mockHomeCubit.state).thenReturn(const HomeError(errorMessage));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows post list when state is success',
        (WidgetTester tester) async {
      final posts = [
        PostModel(
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
          userId: 1,
        ),
      ];

      when(() => mockHomeCubit.state).thenReturn(HomeSuccess(posts));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Body'), findsOneWidget);
    });

    testWidgets('shows empty view when state is initial',
        (WidgetTester tester) async {
      when(() => mockHomeCubit.state).thenReturn(const HomeInitial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No posts available'), findsOneWidget);
    });
  });
}

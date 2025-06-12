import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/di/service_locator.dart';
import 'package:news_app/app/presentation/widgets/empty_view.dart';
import 'package:news_app/app/presentation/widgets/error_view.dart';
import 'package:news_app/app/presentation/widgets/loading_indicator.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_cubit.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_state.dart';
import 'widgets/post_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchPosts(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News App')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      return const LoadingIndicator(message: 'Loading posts...');
    }

    if (state is HomeError) {
      return ErrorView(
        message: state.message,
        onRetry: () {
          context.read<HomeCubit>().fetchPosts();
        },
      );
    }

    if (state is HomeSuccess) {
      return PostList(posts: state.posts);
    }

    return const EmptyView(
      message: 'No posts available',
      icon: Icons.article_outlined,
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/data/repositories/post_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PostRepository _postRepository;

  HomeCubit(this._postRepository) : super(const HomeInitial());

  Future<void> fetchPosts() async {
    try {
      emit(const HomeLoading());
      final posts = await _postRepository.getPosts();
      emit(HomeSuccess(posts));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

import 'package:news_app/app/data/datasources/post_remote_data_source.dart';
import 'package:news_app/app/data/models/post_model.dart';

class PostRepository {
  final PostRemoteDataSource _remoteDataSource;

  PostRepository(this._remoteDataSource);

  Future<List<PostModel>> getPosts() async {
    try {
      return await _remoteDataSource.getPosts();
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }
}

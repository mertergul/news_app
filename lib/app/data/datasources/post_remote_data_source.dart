import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/post_model.dart';

class PostRemoteDataSource {
  final ApiClient _apiClient;

  PostRemoteDataSource(this._apiClient);

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _apiClient.get(ApiConstants.postsEndpoint);
      final List<dynamic> jsonList = response.data as List<dynamic>;
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  Future<PostModel> getPost(int id) async {
    try {
      final response = await _apiClient.get(
        '${ApiConstants.postsEndpoint}/$id',
      );
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch post: $e');
    }
  }

  Future<PostModel> createPost(PostModel post) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.postsEndpoint,
        data: {'userId': post.userId, 'title': post.title, 'body': post.body},
      );
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  Future<PostModel> updatePost(PostModel post) async {
    try {
      final response = await _apiClient.put(
        '${ApiConstants.postsEndpoint}/${post.id}',
        data: {'userId': post.userId, 'title': post.title, 'body': post.body},
      );
      return PostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiClient.delete('${ApiConstants.postsEndpoint}/$id');
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}

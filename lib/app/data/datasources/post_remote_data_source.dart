import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/post_model.dart';

class PostRemoteDataSource {
  final ApiClient _apiClient;

  PostRemoteDataSource(this._apiClient);

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _apiClient.get(ApiConstants.posts);
      final List<dynamic> jsonList = response.data as List<dynamic>;
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}

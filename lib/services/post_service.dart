import 'package:dio/dio.dart';
import 'package:iti/models/post_model.dart';

class PostService {
  Future<List<PostModel>> getPost() async {
    List<PostModel> postsList = [];
      var response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
      var data = response.data;
      data.forEach((element) {
        PostModel user = PostModel.fromJson(element);
        postsList.add(user);
      });

    return postsList;
  }
}
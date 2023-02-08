import 'package:dio/dio.dart';

import '../models/user_model.dart';

class UserService {
  Future<UserModel?> getUserWithId(int id) async {
    UserModel user ;
    try {
      var response = await Dio().get('https://jsonplaceholder.typicode.com/users/$id');
      var data = response.data;
      user = UserModel.fromJson(data);
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
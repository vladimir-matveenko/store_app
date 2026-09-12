import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/network/base_remote_data_source.dart';

import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel?> getProfile();

  Future<UserModel?> updateProfile({
    required int userId,
    String? name,
    String? email,
    String? password,
    String? role,
    String? avatarUrl,
  });
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<UserModel?> getProfile() async {
    return makeRequest<UserModel?>(() async {
      final response = await dio.get('auth/profile');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    });
  }

  @override
  Future<UserModel?> updateProfile({
    required int userId,
    String? name,
    String? email,
    String? password,
    String? role,
    String? avatarUrl,
  }) async {
    final Map<String, dynamic> data = {};
    if (name != null) {
      data.addAll({'name': name});
    }
    if (email != null) {
      data.addAll({'email': email});
    }
    if (password != null) {
      data.addAll({'password': password});
    }
    if (role != null) {
      data.addAll({'role': role});
    }
    if (avatarUrl != null) {
      data.addAll({'avatar': avatarUrl});
    }
    if (data.isEmpty) {
      return null;
    }
    return makeRequest<UserModel?>(() async {
      final response = await dio.put('users/$userId', data: data);
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    });
  }
}

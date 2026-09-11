import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/network/base_remote_data_source.dart';

import '../models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel?> getUserProfile();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<UserModel?> getUserProfile() async {
    return makeRequest<UserModel?>(() async {
      final response = await dio.get('auth/profile');
      if (response.data != null) {
        return UserModel.fromJson(response.data);
      }
      return null;
    });
  }
}

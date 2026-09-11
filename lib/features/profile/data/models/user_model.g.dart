// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': _$UserRoleEnumMap[instance.role]!,
      'avatar': ?instance.avatar,
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.admin: 'admin',
};

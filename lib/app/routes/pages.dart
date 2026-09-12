import 'package:flutter/material.dart';

@immutable
class Pages {
  const Pages._();

  static const splash = '/splash';
  static const login = '/login';
  static const addProduct = 'add-product';
  static const addCategory = 'add-category';
  static const createProfile = '/create-profile';
  static const editProfile = 'edit-profile';
  static const camera = '/camera';

  /// Shell routes
  static const products = '/products';
  static const users = '/users';
  static const locations = '/locations';
  static const profile = '/profile';
}

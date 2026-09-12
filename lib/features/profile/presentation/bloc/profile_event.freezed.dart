// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserProfileRequested value)?  userProfileRequested,TResult Function( CreateProfileRequested value)?  createProfileRequested,TResult Function( UpdateProfileRequested value)?  updateProfileRequested,TResult Function( ImagePicked value)?  imagePicked,TResult Function( ImageRemoved value)?  imageRemoved,TResult Function( DisableSuccessRequested value)?  disableSuccessRequested,TResult Function( DisableErrorRequested value)?  disableErrorRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserProfileRequested() when userProfileRequested != null:
return userProfileRequested(_that);case CreateProfileRequested() when createProfileRequested != null:
return createProfileRequested(_that);case UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that);case ImagePicked() when imagePicked != null:
return imagePicked(_that);case ImageRemoved() when imageRemoved != null:
return imageRemoved(_that);case DisableSuccessRequested() when disableSuccessRequested != null:
return disableSuccessRequested(_that);case DisableErrorRequested() when disableErrorRequested != null:
return disableErrorRequested(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserProfileRequested value)  userProfileRequested,required TResult Function( CreateProfileRequested value)  createProfileRequested,required TResult Function( UpdateProfileRequested value)  updateProfileRequested,required TResult Function( ImagePicked value)  imagePicked,required TResult Function( ImageRemoved value)  imageRemoved,required TResult Function( DisableSuccessRequested value)  disableSuccessRequested,required TResult Function( DisableErrorRequested value)  disableErrorRequested,}){
final _that = this;
switch (_that) {
case UserProfileRequested():
return userProfileRequested(_that);case CreateProfileRequested():
return createProfileRequested(_that);case UpdateProfileRequested():
return updateProfileRequested(_that);case ImagePicked():
return imagePicked(_that);case ImageRemoved():
return imageRemoved(_that);case DisableSuccessRequested():
return disableSuccessRequested(_that);case DisableErrorRequested():
return disableErrorRequested(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserProfileRequested value)?  userProfileRequested,TResult? Function( CreateProfileRequested value)?  createProfileRequested,TResult? Function( UpdateProfileRequested value)?  updateProfileRequested,TResult? Function( ImagePicked value)?  imagePicked,TResult? Function( ImageRemoved value)?  imageRemoved,TResult? Function( DisableSuccessRequested value)?  disableSuccessRequested,TResult? Function( DisableErrorRequested value)?  disableErrorRequested,}){
final _that = this;
switch (_that) {
case UserProfileRequested() when userProfileRequested != null:
return userProfileRequested(_that);case CreateProfileRequested() when createProfileRequested != null:
return createProfileRequested(_that);case UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that);case ImagePicked() when imagePicked != null:
return imagePicked(_that);case ImageRemoved() when imageRemoved != null:
return imageRemoved(_that);case DisableSuccessRequested() when disableSuccessRequested != null:
return disableSuccessRequested(_that);case DisableErrorRequested() when disableErrorRequested != null:
return disableErrorRequested(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  userProfileRequested,TResult Function( String name,  String email,  String password,  String role,  String avatarUrl)?  createProfileRequested,TResult Function( int userId,  String? name,  String? email,  String? password,  String? role)?  updateProfileRequested,TResult Function( Uint8List? bytes)?  imagePicked,TResult Function( AppImageEntity image)?  imageRemoved,TResult Function()?  disableSuccessRequested,TResult Function()?  disableErrorRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserProfileRequested() when userProfileRequested != null:
return userProfileRequested();case CreateProfileRequested() when createProfileRequested != null:
return createProfileRequested(_that.name,_that.email,_that.password,_that.role,_that.avatarUrl);case UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that.userId,_that.name,_that.email,_that.password,_that.role);case ImagePicked() when imagePicked != null:
return imagePicked(_that.bytes);case ImageRemoved() when imageRemoved != null:
return imageRemoved(_that.image);case DisableSuccessRequested() when disableSuccessRequested != null:
return disableSuccessRequested();case DisableErrorRequested() when disableErrorRequested != null:
return disableErrorRequested();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  userProfileRequested,required TResult Function( String name,  String email,  String password,  String role,  String avatarUrl)  createProfileRequested,required TResult Function( int userId,  String? name,  String? email,  String? password,  String? role)  updateProfileRequested,required TResult Function( Uint8List? bytes)  imagePicked,required TResult Function( AppImageEntity image)  imageRemoved,required TResult Function()  disableSuccessRequested,required TResult Function()  disableErrorRequested,}) {final _that = this;
switch (_that) {
case UserProfileRequested():
return userProfileRequested();case CreateProfileRequested():
return createProfileRequested(_that.name,_that.email,_that.password,_that.role,_that.avatarUrl);case UpdateProfileRequested():
return updateProfileRequested(_that.userId,_that.name,_that.email,_that.password,_that.role);case ImagePicked():
return imagePicked(_that.bytes);case ImageRemoved():
return imageRemoved(_that.image);case DisableSuccessRequested():
return disableSuccessRequested();case DisableErrorRequested():
return disableErrorRequested();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  userProfileRequested,TResult? Function( String name,  String email,  String password,  String role,  String avatarUrl)?  createProfileRequested,TResult? Function( int userId,  String? name,  String? email,  String? password,  String? role)?  updateProfileRequested,TResult? Function( Uint8List? bytes)?  imagePicked,TResult? Function( AppImageEntity image)?  imageRemoved,TResult? Function()?  disableSuccessRequested,TResult? Function()?  disableErrorRequested,}) {final _that = this;
switch (_that) {
case UserProfileRequested() when userProfileRequested != null:
return userProfileRequested();case CreateProfileRequested() when createProfileRequested != null:
return createProfileRequested(_that.name,_that.email,_that.password,_that.role,_that.avatarUrl);case UpdateProfileRequested() when updateProfileRequested != null:
return updateProfileRequested(_that.userId,_that.name,_that.email,_that.password,_that.role);case ImagePicked() when imagePicked != null:
return imagePicked(_that.bytes);case ImageRemoved() when imageRemoved != null:
return imageRemoved(_that.image);case DisableSuccessRequested() when disableSuccessRequested != null:
return disableSuccessRequested();case DisableErrorRequested() when disableErrorRequested != null:
return disableErrorRequested();case _:
  return null;

}
}

}

/// @nodoc


class UserProfileRequested implements ProfileEvent {
  const UserProfileRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.userProfileRequested()';
}


}

/// @nodoc
class $UserProfileRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
$UserProfileRequestedCopyWith(UserProfileRequested _, $Res Function(UserProfileRequested) __);
}
/// @nodoc
class _$UserProfileRequestedCopyWithImpl<$Res>
    implements $UserProfileRequestedCopyWith<$Res> {
  _$UserProfileRequestedCopyWithImpl(this._self, this._then);

  final UserProfileRequested _self;
  final $Res Function(UserProfileRequested) _then;




}

/// @nodoc


class CreateProfileRequested implements ProfileEvent {
  const CreateProfileRequested({required this.name, required this.email, required this.password, required this.role, required this.avatarUrl});
  

 final  String name;
 final  String email;
 final  String password;
 final  String role;
 final  String avatarUrl;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateProfileRequestedCopyWith<CreateProfileRequested> get copyWith => _$CreateProfileRequestedCopyWithImpl<CreateProfileRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateProfileRequested&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.role, role) || other.role == role)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,password,role,avatarUrl);

@override
String toString() {
  return 'ProfileEvent.createProfileRequested(name: $name, email: $email, password: $password, role: $role, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $CreateProfileRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $CreateProfileRequestedCopyWith(CreateProfileRequested value, $Res Function(CreateProfileRequested) _then) = _$CreateProfileRequestedCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password, String role, String avatarUrl
});




}
/// @nodoc
class _$CreateProfileRequestedCopyWithImpl<$Res>
    implements $CreateProfileRequestedCopyWith<$Res> {
  _$CreateProfileRequestedCopyWithImpl(this._self, this._then);

  final CreateProfileRequested _self;
  final $Res Function(CreateProfileRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,Object? role = null,Object? avatarUrl = null,}) {
  return _then(CreateProfileRequested(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateProfileRequested implements ProfileEvent {
  const UpdateProfileRequested({required this.userId, this.name, this.email, this.password, this.role});
  

 final  int userId;
 final  String? name;
 final  String? email;
 final  String? password;
 final  String? role;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProfileRequestedCopyWith<UpdateProfileRequested> get copyWith => _$UpdateProfileRequestedCopyWithImpl<UpdateProfileRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProfileRequested&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,userId,name,email,password,role);

@override
String toString() {
  return 'ProfileEvent.updateProfileRequested(userId: $userId, name: $name, email: $email, password: $password, role: $role)';
}


}

/// @nodoc
abstract mixin class $UpdateProfileRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $UpdateProfileRequestedCopyWith(UpdateProfileRequested value, $Res Function(UpdateProfileRequested) _then) = _$UpdateProfileRequestedCopyWithImpl;
@useResult
$Res call({
 int userId, String? name, String? email, String? password, String? role
});




}
/// @nodoc
class _$UpdateProfileRequestedCopyWithImpl<$Res>
    implements $UpdateProfileRequestedCopyWith<$Res> {
  _$UpdateProfileRequestedCopyWithImpl(this._self, this._then);

  final UpdateProfileRequested _self;
  final $Res Function(UpdateProfileRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = freezed,Object? email = freezed,Object? password = freezed,Object? role = freezed,}) {
  return _then(UpdateProfileRequested(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ImagePicked implements ProfileEvent {
  const ImagePicked({this.bytes});
  

 final  Uint8List? bytes;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImagePickedCopyWith<ImagePicked> get copyWith => _$ImagePickedCopyWithImpl<ImagePicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImagePicked&&const DeepCollectionEquality().equals(other.bytes, bytes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'ProfileEvent.imagePicked(bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $ImagePickedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ImagePickedCopyWith(ImagePicked value, $Res Function(ImagePicked) _then) = _$ImagePickedCopyWithImpl;
@useResult
$Res call({
 Uint8List? bytes
});




}
/// @nodoc
class _$ImagePickedCopyWithImpl<$Res>
    implements $ImagePickedCopyWith<$Res> {
  _$ImagePickedCopyWithImpl(this._self, this._then);

  final ImagePicked _self;
  final $Res Function(ImagePicked) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = freezed,}) {
  return _then(ImagePicked(
bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}


}

/// @nodoc


class ImageRemoved implements ProfileEvent {
  const ImageRemoved({required this.image});
  

 final  AppImageEntity image;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageRemovedCopyWith<ImageRemoved> get copyWith => _$ImageRemovedCopyWithImpl<ImageRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageRemoved&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,image);

@override
String toString() {
  return 'ProfileEvent.imageRemoved(image: $image)';
}


}

/// @nodoc
abstract mixin class $ImageRemovedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ImageRemovedCopyWith(ImageRemoved value, $Res Function(ImageRemoved) _then) = _$ImageRemovedCopyWithImpl;
@useResult
$Res call({
 AppImageEntity image
});




}
/// @nodoc
class _$ImageRemovedCopyWithImpl<$Res>
    implements $ImageRemovedCopyWith<$Res> {
  _$ImageRemovedCopyWithImpl(this._self, this._then);

  final ImageRemoved _self;
  final $Res Function(ImageRemoved) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? image = null,}) {
  return _then(ImageRemoved(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as AppImageEntity,
  ));
}


}

/// @nodoc


class DisableSuccessRequested implements ProfileEvent {
  const DisableSuccessRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisableSuccessRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.disableSuccessRequested()';
}


}

/// @nodoc
class $DisableSuccessRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
$DisableSuccessRequestedCopyWith(DisableSuccessRequested _, $Res Function(DisableSuccessRequested) __);
}
/// @nodoc
class _$DisableSuccessRequestedCopyWithImpl<$Res>
    implements $DisableSuccessRequestedCopyWith<$Res> {
  _$DisableSuccessRequestedCopyWithImpl(this._self, this._then);

  final DisableSuccessRequested _self;
  final $Res Function(DisableSuccessRequested) _then;




}

/// @nodoc


class DisableErrorRequested implements ProfileEvent {
  const DisableErrorRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisableErrorRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.disableErrorRequested()';
}


}

/// @nodoc
class $DisableErrorRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
$DisableErrorRequestedCopyWith(DisableErrorRequested _, $Res Function(DisableErrorRequested) __);
}
/// @nodoc
class _$DisableErrorRequestedCopyWithImpl<$Res>
    implements $DisableErrorRequestedCopyWith<$Res> {
  _$DisableErrorRequestedCopyWithImpl(this._self, this._then);

  final DisableErrorRequested _self;
  final $Res Function(DisableErrorRequested) _then;




}

// dart format on

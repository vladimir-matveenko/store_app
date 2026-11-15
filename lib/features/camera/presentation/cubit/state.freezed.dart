// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CameraState {

 CameraStatus get status; List<CameraDescription> get cameras; int get selectedCameraIndex; FlashMode get flashMode; double get minZoom; double get maxZoom; double get zoom; String? get error;
/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraStateCopyWith<CameraState> get copyWith => _$CameraStateCopyWithImpl<CameraState>(this as CameraState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CameraState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.cameras, _this.cameras)&&(identical(other.selectedCameraIndex, _this.selectedCameraIndex) || other.selectedCameraIndex == _this.selectedCameraIndex)&&(identical(other.flashMode, _this.flashMode) || other.flashMode == _this.flashMode)&&(identical(other.minZoom, _this.minZoom) || other.minZoom == _this.minZoom)&&(identical(other.maxZoom, _this.maxZoom) || other.maxZoom == _this.maxZoom)&&(identical(other.zoom, _this.zoom) || other.zoom == _this.zoom)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as CameraState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.cameras),_this.selectedCameraIndex,_this.flashMode,_this.minZoom,_this.maxZoom,_this.zoom,_this.error);
}

@override
String toString() {
  final _this = this as CameraState;
  return 'CameraState(status: ${_this.status}, cameras: ${_this.cameras}, selectedCameraIndex: ${_this.selectedCameraIndex}, flashMode: ${_this.flashMode}, minZoom: ${_this.minZoom}, maxZoom: ${_this.maxZoom}, zoom: ${_this.zoom}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $CameraStateCopyWith<$Res>  {
  factory $CameraStateCopyWith(CameraState value, $Res Function(CameraState) _then) = _$CameraStateCopyWithImpl;
@useResult
$Res call({
 CameraStatus status, List<CameraDescription> cameras, int selectedCameraIndex, FlashMode flashMode, double minZoom, double maxZoom, double zoom, String? error
});




}
/// @nodoc
class _$CameraStateCopyWithImpl<$Res>
    implements $CameraStateCopyWith<$Res> {
  _$CameraStateCopyWithImpl(this._self, this._then);

  final CameraState _self;
  final $Res Function(CameraState) _then;

/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? cameras = null,Object? selectedCameraIndex = null,Object? flashMode = null,Object? minZoom = null,Object? maxZoom = null,Object? zoom = null,Object? error = freezed,}) {
  return _then(CameraState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CameraStatus,cameras: null == cameras ? _self.cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraDescription>,selectedCameraIndex: null == selectedCameraIndex ? _self.selectedCameraIndex : selectedCameraIndex // ignore: cast_nullable_to_non_nullable
as int,flashMode: null == flashMode ? _self.flashMode : flashMode // ignore: cast_nullable_to_non_nullable
as FlashMode,minZoom: null == minZoom ? _self.minZoom : minZoom // ignore: cast_nullable_to_non_nullable
as double,maxZoom: null == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CameraState].
extension CameraStatePatterns on CameraState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CameraState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CameraState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CameraState value)  $default,){
final _that = this;
switch (_that) {
case _CameraState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CameraState value)?  $default,){
final _that = this;
switch (_that) {
case _CameraState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CameraStatus status,  List<CameraDescription> cameras,  int selectedCameraIndex,  FlashMode flashMode,  double minZoom,  double maxZoom,  double zoom,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CameraState() when $default != null:
return $default(_that.status,_that.cameras,_that.selectedCameraIndex,_that.flashMode,_that.minZoom,_that.maxZoom,_that.zoom,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CameraStatus status,  List<CameraDescription> cameras,  int selectedCameraIndex,  FlashMode flashMode,  double minZoom,  double maxZoom,  double zoom,  String? error)  $default,) {final _that = this;
switch (_that) {
case _CameraState():
return $default(_that.status,_that.cameras,_that.selectedCameraIndex,_that.flashMode,_that.minZoom,_that.maxZoom,_that.zoom,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CameraStatus status,  List<CameraDescription> cameras,  int selectedCameraIndex,  FlashMode flashMode,  double minZoom,  double maxZoom,  double zoom,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _CameraState() when $default != null:
return $default(_that.status,_that.cameras,_that.selectedCameraIndex,_that.flashMode,_that.minZoom,_that.maxZoom,_that.zoom,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _CameraState extends CameraState {
  const _CameraState({this.status = CameraStatus.initial,  List<CameraDescription> cameras = const [], this.selectedCameraIndex = 0, this.flashMode = FlashMode.off, this.minZoom = 1.0, this.maxZoom = 1.0, this.zoom = 1.0, this.error}): _cameras = cameras,super._();
  

@override@JsonKey() final  CameraStatus status;
 final  List<CameraDescription> _cameras;
@override@JsonKey() List<CameraDescription> get cameras {
  if (_cameras is EqualUnmodifiableListView) return _cameras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameras);
}

@override@JsonKey() final  int selectedCameraIndex;
@override@JsonKey() final  FlashMode flashMode;
@override@JsonKey() final  double minZoom;
@override@JsonKey() final  double maxZoom;
@override@JsonKey() final  double zoom;
@override final  String? error;

/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraStateCopyWith<_CameraState> get copyWith => __$CameraStateCopyWithImpl<_CameraState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.cameras, _cameras)&&(identical(other.selectedCameraIndex, selectedCameraIndex) || other.selectedCameraIndex == selectedCameraIndex)&&(identical(other.flashMode, flashMode) || other.flashMode == flashMode)&&(identical(other.minZoom, minZoom) || other.minZoom == minZoom)&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_cameras),selectedCameraIndex,flashMode,minZoom,maxZoom,zoom,error);
}

@override
String toString() {
    return 'CameraState(status: $status, cameras: $cameras, selectedCameraIndex: $selectedCameraIndex, flashMode: $flashMode, minZoom: $minZoom, maxZoom: $maxZoom, zoom: $zoom, error: $error)';
}


}

/// @nodoc
abstract mixin class _$CameraStateCopyWith<$Res> implements $CameraStateCopyWith<$Res> {
  factory _$CameraStateCopyWith(_CameraState value, $Res Function(_CameraState) _then) = __$CameraStateCopyWithImpl;
@override @useResult
$Res call({
 CameraStatus status, List<CameraDescription> cameras, int selectedCameraIndex, FlashMode flashMode, double minZoom, double maxZoom, double zoom, String? error
});




}
/// @nodoc
class __$CameraStateCopyWithImpl<$Res>
    implements _$CameraStateCopyWith<$Res> {
  __$CameraStateCopyWithImpl(this._self, this._then);

  final _CameraState _self;
  final $Res Function(_CameraState) _then;

/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? cameras = null,Object? selectedCameraIndex = null,Object? flashMode = null,Object? minZoom = null,Object? maxZoom = null,Object? zoom = null,Object? error = freezed,}) {
  return _then(_CameraState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CameraStatus,cameras: null == cameras ? _self._cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraDescription>,selectedCameraIndex: null == selectedCameraIndex ? _self.selectedCameraIndex : selectedCameraIndex // ignore: cast_nullable_to_non_nullable
as int,flashMode: null == flashMode ? _self.flashMode : flashMode // ignore: cast_nullable_to_non_nullable
as FlashMode,minZoom: null == minZoom ? _self.minZoom : minZoom // ignore: cast_nullable_to_non_nullable
as double,maxZoom: null == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

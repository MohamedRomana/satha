// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_tracking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveTrackingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTrackingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LiveTrackingState()';
}


}

/// @nodoc
class $LiveTrackingStateCopyWith<$Res>  {
$LiveTrackingStateCopyWith(LiveTrackingState _, $Res Function(LiveTrackingState) __);
}


/// Adds pattern-matching-related methods to [LiveTrackingState].
extension LiveTrackingStatePatterns on LiveTrackingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LiveTrackingLoading value)?  loading,TResult Function( LiveTrackingActive value)?  tracking,TResult Function( LiveTrackingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LiveTrackingLoading() when loading != null:
return loading(_that);case LiveTrackingActive() when tracking != null:
return tracking(_that);case LiveTrackingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LiveTrackingLoading value)  loading,required TResult Function( LiveTrackingActive value)  tracking,required TResult Function( LiveTrackingError value)  error,}){
final _that = this;
switch (_that) {
case LiveTrackingLoading():
return loading(_that);case LiveTrackingActive():
return tracking(_that);case LiveTrackingError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LiveTrackingLoading value)?  loading,TResult? Function( LiveTrackingActive value)?  tracking,TResult? Function( LiveTrackingError value)?  error,}){
final _that = this;
switch (_that) {
case LiveTrackingLoading() when loading != null:
return loading(_that);case LiveTrackingActive() when tracking != null:
return tracking(_that);case LiveTrackingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( int tick)?  tracking,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LiveTrackingLoading() when loading != null:
return loading();case LiveTrackingActive() when tracking != null:
return tracking(_that.tick);case LiveTrackingError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( int tick)  tracking,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case LiveTrackingLoading():
return loading();case LiveTrackingActive():
return tracking(_that.tick);case LiveTrackingError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( int tick)?  tracking,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case LiveTrackingLoading() when loading != null:
return loading();case LiveTrackingActive() when tracking != null:
return tracking(_that.tick);case LiveTrackingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class LiveTrackingLoading implements LiveTrackingState {
  const LiveTrackingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTrackingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LiveTrackingState.loading()';
}


}




/// @nodoc


class LiveTrackingActive implements LiveTrackingState {
  const LiveTrackingActive(this.tick);
  

 final  int tick;

/// Create a copy of LiveTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveTrackingActiveCopyWith<LiveTrackingActive> get copyWith => _$LiveTrackingActiveCopyWithImpl<LiveTrackingActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTrackingActive&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,tick);

@override
String toString() {
  return 'LiveTrackingState.tracking(tick: $tick)';
}


}

/// @nodoc
abstract mixin class $LiveTrackingActiveCopyWith<$Res> implements $LiveTrackingStateCopyWith<$Res> {
  factory $LiveTrackingActiveCopyWith(LiveTrackingActive value, $Res Function(LiveTrackingActive) _then) = _$LiveTrackingActiveCopyWithImpl;
@useResult
$Res call({
 int tick
});




}
/// @nodoc
class _$LiveTrackingActiveCopyWithImpl<$Res>
    implements $LiveTrackingActiveCopyWith<$Res> {
  _$LiveTrackingActiveCopyWithImpl(this._self, this._then);

  final LiveTrackingActive _self;
  final $Res Function(LiveTrackingActive) _then;

/// Create a copy of LiveTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tick = null,}) {
  return _then(LiveTrackingActive(
null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LiveTrackingError implements LiveTrackingState {
  const LiveTrackingError(this.message);
  

 final  String message;

/// Create a copy of LiveTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveTrackingErrorCopyWith<LiveTrackingError> get copyWith => _$LiveTrackingErrorCopyWithImpl<LiveTrackingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTrackingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LiveTrackingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LiveTrackingErrorCopyWith<$Res> implements $LiveTrackingStateCopyWith<$Res> {
  factory $LiveTrackingErrorCopyWith(LiveTrackingError value, $Res Function(LiveTrackingError) _then) = _$LiveTrackingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LiveTrackingErrorCopyWithImpl<$Res>
    implements $LiveTrackingErrorCopyWith<$Res> {
  _$LiveTrackingErrorCopyWithImpl(this._self, this._then);

  final LiveTrackingError _self;
  final $Res Function(LiveTrackingError) _then;

/// Create a copy of LiveTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LiveTrackingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

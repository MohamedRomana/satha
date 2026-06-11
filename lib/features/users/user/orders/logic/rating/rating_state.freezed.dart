// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RatingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatingState()';
}


}

/// @nodoc
class $RatingStateCopyWith<$Res>  {
$RatingStateCopyWith(RatingState _, $Res Function(RatingState) __);
}


/// Adds pattern-matching-related methods to [RatingState].
extension RatingStatePatterns on RatingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RatingIdle value)?  idle,TResult Function( RatingSubmitting value)?  submitting,TResult Function( RatingSuccess value)?  success,TResult Function( RatingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RatingIdle() when idle != null:
return idle(_that);case RatingSubmitting() when submitting != null:
return submitting(_that);case RatingSuccess() when success != null:
return success(_that);case RatingError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RatingIdle value)  idle,required TResult Function( RatingSubmitting value)  submitting,required TResult Function( RatingSuccess value)  success,required TResult Function( RatingError value)  error,}){
final _that = this;
switch (_that) {
case RatingIdle():
return idle(_that);case RatingSubmitting():
return submitting(_that);case RatingSuccess():
return success(_that);case RatingError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RatingIdle value)?  idle,TResult? Function( RatingSubmitting value)?  submitting,TResult? Function( RatingSuccess value)?  success,TResult? Function( RatingError value)?  error,}){
final _that = this;
switch (_that) {
case RatingIdle() when idle != null:
return idle(_that);case RatingSubmitting() when submitting != null:
return submitting(_that);case RatingSuccess() when success != null:
return success(_that);case RatingError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  submitting,TResult Function()?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RatingIdle() when idle != null:
return idle();case RatingSubmitting() when submitting != null:
return submitting();case RatingSuccess() when success != null:
return success();case RatingError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  submitting,required TResult Function()  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case RatingIdle():
return idle();case RatingSubmitting():
return submitting();case RatingSuccess():
return success();case RatingError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  submitting,TResult? Function()?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case RatingIdle() when idle != null:
return idle();case RatingSubmitting() when submitting != null:
return submitting();case RatingSuccess() when success != null:
return success();case RatingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RatingIdle implements RatingState {
  const RatingIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatingState.idle()';
}


}




/// @nodoc


class RatingSubmitting implements RatingState {
  const RatingSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatingState.submitting()';
}


}




/// @nodoc


class RatingSuccess implements RatingState {
  const RatingSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RatingState.success()';
}


}




/// @nodoc


class RatingError implements RatingState {
  const RatingError(this.message);
  

 final  String message;

/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingErrorCopyWith<RatingError> get copyWith => _$RatingErrorCopyWithImpl<RatingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RatingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RatingErrorCopyWith<$Res> implements $RatingStateCopyWith<$Res> {
  factory $RatingErrorCopyWith(RatingError value, $Res Function(RatingError) _then) = _$RatingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RatingErrorCopyWithImpl<$Res>
    implements $RatingErrorCopyWith<$Res> {
  _$RatingErrorCopyWithImpl(this._self, this._then);

  final RatingError _self;
  final $Res Function(RatingError) _then;

/// Create a copy of RatingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RatingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_confirm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpConfirmState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpConfirmState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpConfirmState()';
}


}

/// @nodoc
class $OtpConfirmStateCopyWith<$Res>  {
$OtpConfirmStateCopyWith(OtpConfirmState _, $Res Function(OtpConfirmState) __);
}


/// Adds pattern-matching-related methods to [OtpConfirmState].
extension OtpConfirmStatePatterns on OtpConfirmState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OtpConfirmIdle value)?  idle,TResult Function( OtpConfirmVerifying value)?  verifying,TResult Function( OtpConfirmSuccess value)?  success,TResult Function( OtpConfirmError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OtpConfirmIdle() when idle != null:
return idle(_that);case OtpConfirmVerifying() when verifying != null:
return verifying(_that);case OtpConfirmSuccess() when success != null:
return success(_that);case OtpConfirmError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OtpConfirmIdle value)  idle,required TResult Function( OtpConfirmVerifying value)  verifying,required TResult Function( OtpConfirmSuccess value)  success,required TResult Function( OtpConfirmError value)  error,}){
final _that = this;
switch (_that) {
case OtpConfirmIdle():
return idle(_that);case OtpConfirmVerifying():
return verifying(_that);case OtpConfirmSuccess():
return success(_that);case OtpConfirmError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OtpConfirmIdle value)?  idle,TResult? Function( OtpConfirmVerifying value)?  verifying,TResult? Function( OtpConfirmSuccess value)?  success,TResult? Function( OtpConfirmError value)?  error,}){
final _that = this;
switch (_that) {
case OtpConfirmIdle() when idle != null:
return idle(_that);case OtpConfirmVerifying() when verifying != null:
return verifying(_that);case OtpConfirmSuccess() when success != null:
return success(_that);case OtpConfirmError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  verifying,TResult Function()?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OtpConfirmIdle() when idle != null:
return idle();case OtpConfirmVerifying() when verifying != null:
return verifying();case OtpConfirmSuccess() when success != null:
return success();case OtpConfirmError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  verifying,required TResult Function()  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OtpConfirmIdle():
return idle();case OtpConfirmVerifying():
return verifying();case OtpConfirmSuccess():
return success();case OtpConfirmError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  verifying,TResult? Function()?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OtpConfirmIdle() when idle != null:
return idle();case OtpConfirmVerifying() when verifying != null:
return verifying();case OtpConfirmSuccess() when success != null:
return success();case OtpConfirmError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OtpConfirmIdle implements OtpConfirmState {
  const OtpConfirmIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpConfirmIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpConfirmState.idle()';
}


}




/// @nodoc


class OtpConfirmVerifying implements OtpConfirmState {
  const OtpConfirmVerifying();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpConfirmVerifying);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpConfirmState.verifying()';
}


}




/// @nodoc


class OtpConfirmSuccess implements OtpConfirmState {
  const OtpConfirmSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpConfirmSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpConfirmState.success()';
}


}




/// @nodoc


class OtpConfirmError implements OtpConfirmState {
  const OtpConfirmError(this.message);
  

 final  String message;

/// Create a copy of OtpConfirmState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpConfirmErrorCopyWith<OtpConfirmError> get copyWith => _$OtpConfirmErrorCopyWithImpl<OtpConfirmError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpConfirmError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OtpConfirmState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OtpConfirmErrorCopyWith<$Res> implements $OtpConfirmStateCopyWith<$Res> {
  factory $OtpConfirmErrorCopyWith(OtpConfirmError value, $Res Function(OtpConfirmError) _then) = _$OtpConfirmErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OtpConfirmErrorCopyWithImpl<$Res>
    implements $OtpConfirmErrorCopyWith<$Res> {
  _$OtpConfirmErrorCopyWithImpl(this._self, this._then);

  final OtpConfirmError _self;
  final $Res Function(OtpConfirmError) _then;

/// Create a copy of OtpConfirmState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OtpConfirmError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_vehicle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditVehicleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditVehicleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditVehicleState()';
}


}

/// @nodoc
class $EditVehicleStateCopyWith<$Res>  {
$EditVehicleStateCopyWith(EditVehicleState _, $Res Function(EditVehicleState) __);
}


/// Adds pattern-matching-related methods to [EditVehicleState].
extension EditVehicleStatePatterns on EditVehicleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Changed value)?  changed,TResult Function( _Submitting value)?  submitting,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Changed() when changed != null:
return changed(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Changed value)  changed,required TResult Function( _Submitting value)  submitting,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Changed():
return changed(_that);case _Submitting():
return submitting(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Changed value)?  changed,TResult? Function( _Submitting value)?  submitting,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Changed() when changed != null:
return changed(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int tick)?  changed,TResult Function()?  submitting,TResult Function( VehicleModel vehicle)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Changed() when changed != null:
return changed(_that.tick);case _Submitting() when submitting != null:
return submitting();case _Success() when success != null:
return success(_that.vehicle);case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int tick)  changed,required TResult Function()  submitting,required TResult Function( VehicleModel vehicle)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Changed():
return changed(_that.tick);case _Submitting():
return submitting();case _Success():
return success(_that.vehicle);case _Failure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int tick)?  changed,TResult? Function()?  submitting,TResult? Function( VehicleModel vehicle)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Changed() when changed != null:
return changed(_that.tick);case _Submitting() when submitting != null:
return submitting();case _Success() when success != null:
return success(_that.vehicle);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Changed implements EditVehicleState {
  const _Changed(this.tick);
  

 final  int tick;

/// Create a copy of EditVehicleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangedCopyWith<_Changed> get copyWith => __$ChangedCopyWithImpl<_Changed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Changed&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,tick);

@override
String toString() {
  return 'EditVehicleState.changed(tick: $tick)';
}


}

/// @nodoc
abstract mixin class _$ChangedCopyWith<$Res> implements $EditVehicleStateCopyWith<$Res> {
  factory _$ChangedCopyWith(_Changed value, $Res Function(_Changed) _then) = __$ChangedCopyWithImpl;
@useResult
$Res call({
 int tick
});




}
/// @nodoc
class __$ChangedCopyWithImpl<$Res>
    implements _$ChangedCopyWith<$Res> {
  __$ChangedCopyWithImpl(this._self, this._then);

  final _Changed _self;
  final $Res Function(_Changed) _then;

/// Create a copy of EditVehicleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tick = null,}) {
  return _then(_Changed(
null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Submitting implements EditVehicleState {
  const _Submitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditVehicleState.submitting()';
}


}




/// @nodoc


class _Success implements EditVehicleState {
  const _Success(this.vehicle);
  

 final  VehicleModel vehicle;

/// Create a copy of EditVehicleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle));
}


@override
int get hashCode => Object.hash(runtimeType,vehicle);

@override
String toString() {
  return 'EditVehicleState.success(vehicle: $vehicle)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $EditVehicleStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 VehicleModel vehicle
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of EditVehicleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicle = null,}) {
  return _then(_Success(
null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as VehicleModel,
  ));
}


}

/// @nodoc


class _Failure implements EditVehicleState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of EditVehicleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EditVehicleState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $EditVehicleStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of EditVehicleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState()';
}


}

/// @nodoc
class $OrderDetailsStateCopyWith<$Res>  {
$OrderDetailsStateCopyWith(OrderDetailsState _, $Res Function(OrderDetailsState) __);
}


/// Adds pattern-matching-related methods to [OrderDetailsState].
extension OrderDetailsStatePatterns on OrderDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( OrderDetailsLoading value)?  loading,TResult Function( OrderDetailsLoaded value)?  loaded,TResult Function( OrderDetailsError value)?  error,TResult Function( OrderDetailsActionLoading value)?  actionLoading,TResult Function( OrderDetailsActionSuccess value)?  actionSuccess,TResult Function( OrderDetailsActionError value)?  actionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case OrderDetailsLoading() when loading != null:
return loading(_that);case OrderDetailsLoaded() when loaded != null:
return loaded(_that);case OrderDetailsError() when error != null:
return error(_that);case OrderDetailsActionLoading() when actionLoading != null:
return actionLoading(_that);case OrderDetailsActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case OrderDetailsActionError() when actionError != null:
return actionError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( OrderDetailsLoading value)  loading,required TResult Function( OrderDetailsLoaded value)  loaded,required TResult Function( OrderDetailsError value)  error,required TResult Function( OrderDetailsActionLoading value)  actionLoading,required TResult Function( OrderDetailsActionSuccess value)  actionSuccess,required TResult Function( OrderDetailsActionError value)  actionError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case OrderDetailsLoading():
return loading(_that);case OrderDetailsLoaded():
return loaded(_that);case OrderDetailsError():
return error(_that);case OrderDetailsActionLoading():
return actionLoading(_that);case OrderDetailsActionSuccess():
return actionSuccess(_that);case OrderDetailsActionError():
return actionError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( OrderDetailsLoading value)?  loading,TResult? Function( OrderDetailsLoaded value)?  loaded,TResult? Function( OrderDetailsError value)?  error,TResult? Function( OrderDetailsActionLoading value)?  actionLoading,TResult? Function( OrderDetailsActionSuccess value)?  actionSuccess,TResult? Function( OrderDetailsActionError value)?  actionError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case OrderDetailsLoading() when loading != null:
return loading(_that);case OrderDetailsLoaded() when loaded != null:
return loaded(_that);case OrderDetailsError() when error != null:
return error(_that);case OrderDetailsActionLoading() when actionLoading != null:
return actionLoading(_that);case OrderDetailsActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case OrderDetailsActionError() when actionError != null:
return actionError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderModel order)?  loaded,TResult Function( String message)?  error,TResult Function()?  actionLoading,TResult Function( String message)?  actionSuccess,TResult Function( String message)?  actionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case OrderDetailsLoading() when loading != null:
return loading();case OrderDetailsLoaded() when loaded != null:
return loaded(_that.order);case OrderDetailsError() when error != null:
return error(_that.message);case OrderDetailsActionLoading() when actionLoading != null:
return actionLoading();case OrderDetailsActionSuccess() when actionSuccess != null:
return actionSuccess(_that.message);case OrderDetailsActionError() when actionError != null:
return actionError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderModel order)  loaded,required TResult Function( String message)  error,required TResult Function()  actionLoading,required TResult Function( String message)  actionSuccess,required TResult Function( String message)  actionError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case OrderDetailsLoading():
return loading();case OrderDetailsLoaded():
return loaded(_that.order);case OrderDetailsError():
return error(_that.message);case OrderDetailsActionLoading():
return actionLoading();case OrderDetailsActionSuccess():
return actionSuccess(_that.message);case OrderDetailsActionError():
return actionError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderModel order)?  loaded,TResult? Function( String message)?  error,TResult? Function()?  actionLoading,TResult? Function( String message)?  actionSuccess,TResult? Function( String message)?  actionError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case OrderDetailsLoading() when loading != null:
return loading();case OrderDetailsLoaded() when loaded != null:
return loaded(_that.order);case OrderDetailsError() when error != null:
return error(_that.message);case OrderDetailsActionLoading() when actionLoading != null:
return actionLoading();case OrderDetailsActionSuccess() when actionSuccess != null:
return actionSuccess(_that.message);case OrderDetailsActionError() when actionError != null:
return actionError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements OrderDetailsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.initial()';
}


}




/// @nodoc


class OrderDetailsLoading implements OrderDetailsState {
  const OrderDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.loading()';
}


}




/// @nodoc


class OrderDetailsLoaded implements OrderDetailsState {
  const OrderDetailsLoaded(this.order);
  

 final  OrderModel order;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsLoadedCopyWith<OrderDetailsLoaded> get copyWith => _$OrderDetailsLoadedCopyWithImpl<OrderDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsLoaded&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderDetailsState.loaded(order: $order)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsLoadedCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsLoadedCopyWith(OrderDetailsLoaded value, $Res Function(OrderDetailsLoaded) _then) = _$OrderDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 OrderModel order
});




}
/// @nodoc
class _$OrderDetailsLoadedCopyWithImpl<$Res>
    implements $OrderDetailsLoadedCopyWith<$Res> {
  _$OrderDetailsLoadedCopyWithImpl(this._self, this._then);

  final OrderDetailsLoaded _self;
  final $Res Function(OrderDetailsLoaded) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(OrderDetailsLoaded(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderModel,
  ));
}


}

/// @nodoc


class OrderDetailsError implements OrderDetailsState {
  const OrderDetailsError(this.message);
  

 final  String message;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsErrorCopyWith<OrderDetailsError> get copyWith => _$OrderDetailsErrorCopyWithImpl<OrderDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsErrorCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsErrorCopyWith(OrderDetailsError value, $Res Function(OrderDetailsError) _then) = _$OrderDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrderDetailsErrorCopyWithImpl<$Res>
    implements $OrderDetailsErrorCopyWith<$Res> {
  _$OrderDetailsErrorCopyWithImpl(this._self, this._then);

  final OrderDetailsError _self;
  final $Res Function(OrderDetailsError) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrderDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OrderDetailsActionLoading implements OrderDetailsState {
  const OrderDetailsActionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsActionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.actionLoading()';
}


}




/// @nodoc


class OrderDetailsActionSuccess implements OrderDetailsState {
  const OrderDetailsActionSuccess(this.message);
  

 final  String message;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsActionSuccessCopyWith<OrderDetailsActionSuccess> get copyWith => _$OrderDetailsActionSuccessCopyWithImpl<OrderDetailsActionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsActionSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderDetailsState.actionSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsActionSuccessCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsActionSuccessCopyWith(OrderDetailsActionSuccess value, $Res Function(OrderDetailsActionSuccess) _then) = _$OrderDetailsActionSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrderDetailsActionSuccessCopyWithImpl<$Res>
    implements $OrderDetailsActionSuccessCopyWith<$Res> {
  _$OrderDetailsActionSuccessCopyWithImpl(this._self, this._then);

  final OrderDetailsActionSuccess _self;
  final $Res Function(OrderDetailsActionSuccess) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrderDetailsActionSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OrderDetailsActionError implements OrderDetailsState {
  const OrderDetailsActionError(this.message);
  

 final  String message;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsActionErrorCopyWith<OrderDetailsActionError> get copyWith => _$OrderDetailsActionErrorCopyWithImpl<OrderDetailsActionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsActionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderDetailsState.actionError(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsActionErrorCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsActionErrorCopyWith(OrderDetailsActionError value, $Res Function(OrderDetailsActionError) _then) = _$OrderDetailsActionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrderDetailsActionErrorCopyWithImpl<$Res>
    implements $OrderDetailsActionErrorCopyWith<$Res> {
  _$OrderDetailsActionErrorCopyWithImpl(this._self, this._then);

  final OrderDetailsActionError _self;
  final $Res Function(OrderDetailsActionError) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrderDetailsActionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

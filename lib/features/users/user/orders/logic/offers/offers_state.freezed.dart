// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OffersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OffersState()';
}


}

/// @nodoc
class $OffersStateCopyWith<$Res>  {
$OffersStateCopyWith(OffersState _, $Res Function(OffersState) __);
}


/// Adds pattern-matching-related methods to [OffersState].
extension OffersStatePatterns on OffersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OffersLoading value)?  loading,TResult Function( OffersLoaded value)?  loaded,TResult Function( OffersError value)?  error,TResult Function( OffersAccepting value)?  accepting,TResult Function( OffersAccepted value)?  accepted,TResult Function( OffersActionError value)?  actionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OffersLoading() when loading != null:
return loading(_that);case OffersLoaded() when loaded != null:
return loaded(_that);case OffersError() when error != null:
return error(_that);case OffersAccepting() when accepting != null:
return accepting(_that);case OffersAccepted() when accepted != null:
return accepted(_that);case OffersActionError() when actionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OffersLoading value)  loading,required TResult Function( OffersLoaded value)  loaded,required TResult Function( OffersError value)  error,required TResult Function( OffersAccepting value)  accepting,required TResult Function( OffersAccepted value)  accepted,required TResult Function( OffersActionError value)  actionError,}){
final _that = this;
switch (_that) {
case OffersLoading():
return loading(_that);case OffersLoaded():
return loaded(_that);case OffersError():
return error(_that);case OffersAccepting():
return accepting(_that);case OffersAccepted():
return accepted(_that);case OffersActionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OffersLoading value)?  loading,TResult? Function( OffersLoaded value)?  loaded,TResult? Function( OffersError value)?  error,TResult? Function( OffersAccepting value)?  accepting,TResult? Function( OffersAccepted value)?  accepted,TResult? Function( OffersActionError value)?  actionError,}){
final _that = this;
switch (_that) {
case OffersLoading() when loading != null:
return loading(_that);case OffersLoaded() when loaded != null:
return loaded(_that);case OffersError() when error != null:
return error(_that);case OffersAccepting() when accepting != null:
return accepting(_that);case OffersAccepted() when accepted != null:
return accepted(_that);case OffersActionError() when actionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( int tick)?  loaded,TResult Function( String message)?  error,TResult Function()?  accepting,TResult Function( OfferModel offer)?  accepted,TResult Function( String message)?  actionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OffersLoading() when loading != null:
return loading();case OffersLoaded() when loaded != null:
return loaded(_that.tick);case OffersError() when error != null:
return error(_that.message);case OffersAccepting() when accepting != null:
return accepting();case OffersAccepted() when accepted != null:
return accepted(_that.offer);case OffersActionError() when actionError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( int tick)  loaded,required TResult Function( String message)  error,required TResult Function()  accepting,required TResult Function( OfferModel offer)  accepted,required TResult Function( String message)  actionError,}) {final _that = this;
switch (_that) {
case OffersLoading():
return loading();case OffersLoaded():
return loaded(_that.tick);case OffersError():
return error(_that.message);case OffersAccepting():
return accepting();case OffersAccepted():
return accepted(_that.offer);case OffersActionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( int tick)?  loaded,TResult? Function( String message)?  error,TResult? Function()?  accepting,TResult? Function( OfferModel offer)?  accepted,TResult? Function( String message)?  actionError,}) {final _that = this;
switch (_that) {
case OffersLoading() when loading != null:
return loading();case OffersLoaded() when loaded != null:
return loaded(_that.tick);case OffersError() when error != null:
return error(_that.message);case OffersAccepting() when accepting != null:
return accepting();case OffersAccepted() when accepted != null:
return accepted(_that.offer);case OffersActionError() when actionError != null:
return actionError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OffersLoading implements OffersState {
  const OffersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OffersState.loading()';
}


}




/// @nodoc


class OffersLoaded implements OffersState {
  const OffersLoaded(this.tick);
  

 final  int tick;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffersLoadedCopyWith<OffersLoaded> get copyWith => _$OffersLoadedCopyWithImpl<OffersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersLoaded&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,tick);

@override
String toString() {
  return 'OffersState.loaded(tick: $tick)';
}


}

/// @nodoc
abstract mixin class $OffersLoadedCopyWith<$Res> implements $OffersStateCopyWith<$Res> {
  factory $OffersLoadedCopyWith(OffersLoaded value, $Res Function(OffersLoaded) _then) = _$OffersLoadedCopyWithImpl;
@useResult
$Res call({
 int tick
});




}
/// @nodoc
class _$OffersLoadedCopyWithImpl<$Res>
    implements $OffersLoadedCopyWith<$Res> {
  _$OffersLoadedCopyWithImpl(this._self, this._then);

  final OffersLoaded _self;
  final $Res Function(OffersLoaded) _then;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tick = null,}) {
  return _then(OffersLoaded(
null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OffersError implements OffersState {
  const OffersError(this.message);
  

 final  String message;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffersErrorCopyWith<OffersError> get copyWith => _$OffersErrorCopyWithImpl<OffersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OffersState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OffersErrorCopyWith<$Res> implements $OffersStateCopyWith<$Res> {
  factory $OffersErrorCopyWith(OffersError value, $Res Function(OffersError) _then) = _$OffersErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OffersErrorCopyWithImpl<$Res>
    implements $OffersErrorCopyWith<$Res> {
  _$OffersErrorCopyWithImpl(this._self, this._then);

  final OffersError _self;
  final $Res Function(OffersError) _then;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OffersError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OffersAccepting implements OffersState {
  const OffersAccepting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersAccepting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OffersState.accepting()';
}


}




/// @nodoc


class OffersAccepted implements OffersState {
  const OffersAccepted(this.offer);
  

 final  OfferModel offer;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffersAcceptedCopyWith<OffersAccepted> get copyWith => _$OffersAcceptedCopyWithImpl<OffersAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersAccepted&&(identical(other.offer, offer) || other.offer == offer));
}


@override
int get hashCode => Object.hash(runtimeType,offer);

@override
String toString() {
  return 'OffersState.accepted(offer: $offer)';
}


}

/// @nodoc
abstract mixin class $OffersAcceptedCopyWith<$Res> implements $OffersStateCopyWith<$Res> {
  factory $OffersAcceptedCopyWith(OffersAccepted value, $Res Function(OffersAccepted) _then) = _$OffersAcceptedCopyWithImpl;
@useResult
$Res call({
 OfferModel offer
});




}
/// @nodoc
class _$OffersAcceptedCopyWithImpl<$Res>
    implements $OffersAcceptedCopyWith<$Res> {
  _$OffersAcceptedCopyWithImpl(this._self, this._then);

  final OffersAccepted _self;
  final $Res Function(OffersAccepted) _then;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? offer = null,}) {
  return _then(OffersAccepted(
null == offer ? _self.offer : offer // ignore: cast_nullable_to_non_nullable
as OfferModel,
  ));
}


}

/// @nodoc


class OffersActionError implements OffersState {
  const OffersActionError(this.message);
  

 final  String message;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffersActionErrorCopyWith<OffersActionError> get copyWith => _$OffersActionErrorCopyWithImpl<OffersActionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersActionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OffersState.actionError(message: $message)';
}


}

/// @nodoc
abstract mixin class $OffersActionErrorCopyWith<$Res> implements $OffersStateCopyWith<$Res> {
  factory $OffersActionErrorCopyWith(OffersActionError value, $Res Function(OffersActionError) _then) = _$OffersActionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OffersActionErrorCopyWithImpl<$Res>
    implements $OffersActionErrorCopyWith<$Res> {
  _$OffersActionErrorCopyWithImpl(this._self, this._then);

  final OffersActionError _self;
  final $Res Function(OffersActionError) _then;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OffersActionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

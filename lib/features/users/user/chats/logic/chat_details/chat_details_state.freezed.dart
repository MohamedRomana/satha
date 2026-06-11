// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatDetailsState()';
}


}

/// @nodoc
class $ChatDetailsStateCopyWith<$Res>  {
$ChatDetailsStateCopyWith(ChatDetailsState _, $Res Function(ChatDetailsState) __);
}


/// Adds pattern-matching-related methods to [ChatDetailsState].
extension ChatDetailsStatePatterns on ChatDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatDetailsLoading value)?  loading,TResult Function( ChatDetailsLoaded value)?  loaded,TResult Function( ChatDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatDetailsLoading() when loading != null:
return loading(_that);case ChatDetailsLoaded() when loaded != null:
return loaded(_that);case ChatDetailsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatDetailsLoading value)  loading,required TResult Function( ChatDetailsLoaded value)  loaded,required TResult Function( ChatDetailsError value)  error,}){
final _that = this;
switch (_that) {
case ChatDetailsLoading():
return loading(_that);case ChatDetailsLoaded():
return loaded(_that);case ChatDetailsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatDetailsLoading value)?  loading,TResult? Function( ChatDetailsLoaded value)?  loaded,TResult? Function( ChatDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case ChatDetailsLoading() when loading != null:
return loading(_that);case ChatDetailsLoaded() when loaded != null:
return loaded(_that);case ChatDetailsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( int tick)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatDetailsLoading() when loading != null:
return loading();case ChatDetailsLoaded() when loaded != null:
return loaded(_that.tick);case ChatDetailsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( int tick)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ChatDetailsLoading():
return loading();case ChatDetailsLoaded():
return loaded(_that.tick);case ChatDetailsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( int tick)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ChatDetailsLoading() when loading != null:
return loading();case ChatDetailsLoaded() when loaded != null:
return loaded(_that.tick);case ChatDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChatDetailsLoading implements ChatDetailsState {
  const ChatDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatDetailsState.loading()';
}


}




/// @nodoc


class ChatDetailsLoaded implements ChatDetailsState {
  const ChatDetailsLoaded(this.tick);
  

 final  int tick;

/// Create a copy of ChatDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDetailsLoadedCopyWith<ChatDetailsLoaded> get copyWith => _$ChatDetailsLoadedCopyWithImpl<ChatDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetailsLoaded&&(identical(other.tick, tick) || other.tick == tick));
}


@override
int get hashCode => Object.hash(runtimeType,tick);

@override
String toString() {
  return 'ChatDetailsState.loaded(tick: $tick)';
}


}

/// @nodoc
abstract mixin class $ChatDetailsLoadedCopyWith<$Res> implements $ChatDetailsStateCopyWith<$Res> {
  factory $ChatDetailsLoadedCopyWith(ChatDetailsLoaded value, $Res Function(ChatDetailsLoaded) _then) = _$ChatDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 int tick
});




}
/// @nodoc
class _$ChatDetailsLoadedCopyWithImpl<$Res>
    implements $ChatDetailsLoadedCopyWith<$Res> {
  _$ChatDetailsLoadedCopyWithImpl(this._self, this._then);

  final ChatDetailsLoaded _self;
  final $Res Function(ChatDetailsLoaded) _then;

/// Create a copy of ChatDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tick = null,}) {
  return _then(ChatDetailsLoaded(
null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChatDetailsError implements ChatDetailsState {
  const ChatDetailsError(this.message);
  

 final  String message;

/// Create a copy of ChatDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDetailsErrorCopyWith<ChatDetailsError> get copyWith => _$ChatDetailsErrorCopyWithImpl<ChatDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatDetailsErrorCopyWith<$Res> implements $ChatDetailsStateCopyWith<$Res> {
  factory $ChatDetailsErrorCopyWith(ChatDetailsError value, $Res Function(ChatDetailsError) _then) = _$ChatDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatDetailsErrorCopyWithImpl<$Res>
    implements $ChatDetailsErrorCopyWith<$Res> {
  _$ChatDetailsErrorCopyWithImpl(this._self, this._then);

  final ChatDetailsError _self;
  final $Res Function(ChatDetailsError) _then;

/// Create a copy of ChatDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

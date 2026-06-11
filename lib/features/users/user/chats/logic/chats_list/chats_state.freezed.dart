// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatsState()';
}


}

/// @nodoc
class $ChatsStateCopyWith<$Res>  {
$ChatsStateCopyWith(ChatsState _, $Res Function(ChatsState) __);
}


/// Adds pattern-matching-related methods to [ChatsState].
extension ChatsStatePatterns on ChatsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ChatsLoading value)?  loading,TResult Function( ChatsSuccess value)?  success,TResult Function( ChatsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ChatsLoading() when loading != null:
return loading(_that);case ChatsSuccess() when success != null:
return success(_that);case ChatsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ChatsLoading value)  loading,required TResult Function( ChatsSuccess value)  success,required TResult Function( ChatsError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ChatsLoading():
return loading(_that);case ChatsSuccess():
return success(_that);case ChatsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ChatsLoading value)?  loading,TResult? Function( ChatsSuccess value)?  success,TResult? Function( ChatsError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ChatsLoading() when loading != null:
return loading(_that);case ChatsSuccess() when success != null:
return success(_that);case ChatsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ChatModel> chats)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ChatsLoading() when loading != null:
return loading();case ChatsSuccess() when success != null:
return success(_that.chats);case ChatsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ChatModel> chats)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ChatsLoading():
return loading();case ChatsSuccess():
return success(_that.chats);case ChatsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ChatModel> chats)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ChatsLoading() when loading != null:
return loading();case ChatsSuccess() when success != null:
return success(_that.chats);case ChatsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ChatsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatsState.initial()';
}


}




/// @nodoc


class ChatsLoading implements ChatsState {
  const ChatsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatsState.loading()';
}


}




/// @nodoc


class ChatsSuccess implements ChatsState {
  const ChatsSuccess(final  List<ChatModel> chats): _chats = chats;
  

 final  List<ChatModel> _chats;
 List<ChatModel> get chats {
  if (_chats is EqualUnmodifiableListView) return _chats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chats);
}


/// Create a copy of ChatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsSuccessCopyWith<ChatsSuccess> get copyWith => _$ChatsSuccessCopyWithImpl<ChatsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsSuccess&&const DeepCollectionEquality().equals(other._chats, _chats));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chats));

@override
String toString() {
  return 'ChatsState.success(chats: $chats)';
}


}

/// @nodoc
abstract mixin class $ChatsSuccessCopyWith<$Res> implements $ChatsStateCopyWith<$Res> {
  factory $ChatsSuccessCopyWith(ChatsSuccess value, $Res Function(ChatsSuccess) _then) = _$ChatsSuccessCopyWithImpl;
@useResult
$Res call({
 List<ChatModel> chats
});




}
/// @nodoc
class _$ChatsSuccessCopyWithImpl<$Res>
    implements $ChatsSuccessCopyWith<$Res> {
  _$ChatsSuccessCopyWithImpl(this._self, this._then);

  final ChatsSuccess _self;
  final $Res Function(ChatsSuccess) _then;

/// Create a copy of ChatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? chats = null,}) {
  return _then(ChatsSuccess(
null == chats ? _self._chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatModel>,
  ));
}


}

/// @nodoc


class ChatsError implements ChatsState {
  const ChatsError(this.message);
  

 final  String message;

/// Create a copy of ChatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsErrorCopyWith<ChatsError> get copyWith => _$ChatsErrorCopyWithImpl<ChatsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatsErrorCopyWith<$Res> implements $ChatsStateCopyWith<$Res> {
  factory $ChatsErrorCopyWith(ChatsError value, $Res Function(ChatsError) _then) = _$ChatsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatsErrorCopyWithImpl<$Res>
    implements $ChatsErrorCopyWith<$Res> {
  _$ChatsErrorCopyWithImpl(this._self, this._then);

  final ChatsError _self;
  final $Res Function(ChatsError) _then;

/// Create a copy of ChatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

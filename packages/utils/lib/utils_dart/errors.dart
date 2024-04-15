import 'dart:async';

/// Executes a callback function and handles any synchronous errors.
/// Sync clone of [FutureExtensions.onError]
///
/// The [cb] is the callback function to execute.
/// The [onError] is a function that handles any errors that occur during the execution of the callback.
T onErrorSync<T, E extends Object>(
  T Function() cb,
  T Function(E error, StackTrace stackTrace) handleError, {
  bool Function(E error)? test,
}) {
  T onError(Object error, StackTrace stackTrace) {
    if (error is! E || test != null && !test(error)) {
      // Counts as rethrow, preserves stack trace.
      throw error;
    }
    return handleError(error, stackTrace);
  }

  try {
    return cb();
  } catch (e, st) {
    return onError(e, st);
  }
}

/// A helper function that handles errors in asynchronous operations.
/// This function is useful if we want to limit try catch operation to specific part of the code.
///
/// The [tryCatchAsync] function takes a callback function [cb] that returns a
/// [FutureOr] value. It also accepts optional callback functions [onSuccess]
/// and [onError] that are executed based on the success or failure of the
/// asynchronous operation.
///
/// If the [cb] function completes successfully, the [onSuccess] callback is
/// executed with the result value. If an error occurs during the execution of
/// the [cb] function, the [onError] callback is executed with the error object
/// and the stack trace.
///
/// The [tryCatchAsync] function returns a [FutureOr] value, which can be used
/// to await the completion of the asynchronous operation.
FutureOr<void> tryCatchAsync<T>(
  FutureOr<T> Function() cb, {
  FutureOr<void> Function(T value)? onSuccess,
  FutureOr<void> Function(Object error, StackTrace stackTrace)? onError,
}) async {
  late final T res;
  var success = false;
  try {
    res = await cb();
    success = true;
  } catch (e, st) {
    if (onError == null) {
      rethrow;
    }
    await onError.call(e, st);
  }
  if (success) {
    await onSuccess?.call(res);
  }
}

/// A helper function that handles errors in asynchronous operations.
/// This function is useful if we want to limit try catch operation to specific part of the code.
///
/// Sync version of [tryCatchAsync]
FutureOr<void> tryCatchSync<T>(
  T Function() cb, {
  void Function(T value)? onSuccess,
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  late final T res;
  var success = false;
  try {
    res = cb();
    success = true;
  } catch (e, st) {
    if (onError == null) {
      rethrow;
    }
    onError.call(e, st);
  }
  if (success) {
    onSuccess?.call(res);
  }
}

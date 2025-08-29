import 'dart:async';

extension FutureExtension<T> on Future<T> {
  Future<T> withCompleter(Completer<void> c) {
    return thenSideEffect((result) => c.complete()).onErrorRethrow(cb: (e, st) => c.completeError(e!, st));
  }
}

Future<List<T>> futureWait<T>(
  Iterable<FutureOr<T>> futures, {
  bool eagerError = false,
  void Function(T successValue)? cleanUp,
}) =>
    Future.wait(
      futures.map((e) => (() async => await e)()),
      eagerError: eagerError,
      cleanUp: cleanUp,
    );

extension FutureExtensionOnError<T> on Future<T> {
  /// A utility method that allows performing a side effect on the result of a [Future].
  ///
  /// The [thenSideEffect] method takes a callback function [cb] that will be called with the result of the [Future].
  /// The [shouldRethrow] parameter determines whether any caught exceptions should be rethrown or not.
  /// The [shouldAwait] parameter determines whether the callback function should be awaited or not.
  ///
  /// Returns a [Future] that completes with the original result of the [Future].
  Future<T> thenSideEffect(
    FutureOr<void> Function(T result) cb, {
    bool shouldRethrow = true,
    bool shouldAwait = true,
  }) =>
      then((result) async {
        try {
          final f = cb(result);
          if (shouldAwait) {
            await f;
          }
        } catch (e) {
          if (shouldRethrow) {
            rethrow;
          }
        }
        return result;
      });

  /// A utility function that handles errors and returns a nullable value.
  ///
  /// The [onErrorNull] function is used to handle errors that may occur during the execution of a future.
  /// It takes an optional callback function [cb] and an optional test function [test].
  /// The [cb] function is called when an error of type [E] occurs and the [test] function returns true (or if [test] is null).
  /// The [cb] function is passed the error [e] and the stack trace [st].
  /// If the [cb] function is not provided or if it returns null, the error is rethrown.
  /// If the error is not of type [E] or if the [test] function returns false, the error is rethrown.
  /// If no error occurs, the [onErrorNull] function returns the result of the future [this].
  ///
  /// Example usage:
  /// ```dart
  /// Future<int> fetchData() async {
  ///   // Simulate an error
  ///   throw Exception('Error occurred');
  /// }
  ///
  /// void handleError(Exception e, StackTrace st) {
  ///   print('Error: $e');
  /// }
  ///
  /// void main() async {
  ///   var result = await fetchData().onErrorNullable<Exception>(cb: handleError);
  ///   print(result); // Output: null
  /// }
  /// ```
  Future<T?> onErrorNull<E extends Object>({
    FutureOr<void> Function(E e, StackTrace st)? cb,
    bool Function(E e)? test,
  }) async {
    try {
      return await this;
    } catch (e, st) {
      if (e is E && (test == null || test(e))) {
        await cb?.call(e, st);
        return null;
      }
      rethrow;
    }
  }

  /// A utility function that allows handling and rethrowing of specific exceptions.
  ///
  /// The [onErrorRethrow] function is used to handle exceptions of type [E] that may occur during the execution of a future.
  /// It takes two optional parameters:
  /// - [cb]: A callback function that is called when an exception of type [E] is caught. It takes the exception [e] and the stack trace [st] as parameters.
  /// - [test]: A boolean function that can be used to filter exceptions of type [E]. If the function returns true, the callback [cb] will be called.
  ///
  /// The function returns a future of type [T].
  /// If no exception of type [E] is caught, the original future is returned.
  /// If an exception of type [E] is caught and the [test] function returns true (or is not provided), the [cb] callback is called with the exception [e] and stack trace [st].
  /// After the callback is called, the exception is rethrown.
  ///
  /// Example usage:
  /// ```dart
  /// Future<int> fetchData() async {
  ///   // Simulating an exception
  ///   throw Exception('Failed to fetch data');
  /// }
  ///
  /// void handleError(Exception e, StackTrace st) {
  ///   print('Error: $e');
  ///   print('Stack trace: $st');
  /// }
  ///
  /// Future<void> main() async {
  ///   await fetchData().onErrorWithRethrow<Exception>(cb: handleError);
  ///   print('This line will not be executed');
  /// }
  /// ```
  Future<T> onErrorRethrow<E extends Object>({
    FutureOr<void> Function(E e, StackTrace st)? cb,
    bool Function(E e)? test,
  }) async {
    try {
      return await this;
    } catch (e, st) {
      if (e is E && (test == null || test(e))) {
        await cb?.call(e, st);
      }
      rethrow;
    }
  }
}

import 'dart:async';

/// Extension method on [StreamSink] that adds a non-blocking stream to the sink.
extension StreamSinkAddStreamNonBlockingExtension<T> on StreamSink<T> {
  /// Non-blocking version of [addStream].
  ///
  /// The elements from the [other] stream are added to the sink by calling the
  /// [add] method. If an error occurs in the [other] stream, the [addError]
  /// method is called on the sink.
  StreamSubscription<T> addStreamNonBlocking(Stream<T> other) {
    return other.listen(
      add,
      onError: addError,
    );
  }
}

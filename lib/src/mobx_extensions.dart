import 'dart:async';

import 'package:mobx/mobx.dart' hide Listenable;
import 'package:utils/utils.dart';

extension ObservableToStream<T> on Observable<T> {
  Stream<T> toStream() => MobxUtils.fromGetter(() => value);

  ObservableStream<T> toObsStream() => toStream().obs();
}

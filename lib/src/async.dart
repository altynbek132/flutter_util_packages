import 'dart:async';

import 'package:mobx/mobx.dart';

// WARNING, DO NOT AWAIT, if awaited and replaced indefinite await
ObservableFuture<T> makePendingFuture<T>() => ObservableFuture<T>(Completer<T>().future);

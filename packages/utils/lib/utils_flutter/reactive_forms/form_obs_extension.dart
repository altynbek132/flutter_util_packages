import 'package:disposing/disposing_dart.dart';
import 'package:mobx/mobx.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:utils/utils_flutter/reactive_forms/form_control_extension.dart';

extension FormGroupExtensionToObs on FormGroup {
  SyncValueDisposable<Observable<FormGroup>> toObs() {
    final obs = Observable(this);
    final sub = allChanges.listen((status) => runInAction(() => obs.reportManualChange()));
    return SyncValueDisposable(obs, () => sub.cancel());
  }
}

extension FormControlExtensionToObs<T> on FormControl<T> {
  SyncValueDisposable<Observable<FormControl<T>>> toObs() {
    final obs = Observable(this);
    final sub = allChanges.listen((status) => runInAction(() => obs.reportManualChange()));
    return SyncValueDisposable(obs, () => sub.cancel());
  }
}

import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

/// [ReactiveFormFieldState._showErrors]
extension FormControlErrorsExtension<T> on FormControl<T> {
  bool get showErrors {
    return invalid && touched;
  }

  Stream<void> get allChanges {
    return MergeStream([
      valueChanges,
      touchChanges,
      statusChanged,
      focusChanges,
    ]);
  }
}

extension FormGroupAllChangesExtension on FormGroup {
  Stream<void> get allChanges {
    return MergeStream([
      valueChanges,
      touchChanges,
      statusChanged,
    ]);
  }
}

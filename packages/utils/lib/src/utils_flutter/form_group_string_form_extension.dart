import 'package:reactive_forms/reactive_forms.dart';

extension FormGroupStringFormExtension on FormGroup {
  FormControl<String> control_(String key) {
    final control = this.control(key);
    if (control is FormControl<String>) {
      return control;
    } else {
      throw Exception('Control with key $key is not a FormControl<String>');
    }
  }

  FormControl controlDynamic(String key) {
    return control(key) as FormControl;
  }
}

import 'package:igrejoteca_app/modules/login/store/atoms/signup_atoms.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SignupReducer extends RxReducer {
  SignupReducer() {
    on(() => [changeNextButton], _changeNextButton);
  }

  void _changeNextButton() {
    validNext.setValue(changeNextButton.value);
  }
}

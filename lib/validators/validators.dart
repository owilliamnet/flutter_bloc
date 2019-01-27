import 'dart:async';

import '../utils/string_util.dart';

mixin Validators {
  var loginValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (login, snik) {
    if (login != null && login.length >= 4)
      snik.add(login);
    else
      snik.addError(StringUtil.loginInvalido);
  });

  var senhaValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, snik) {
    if (senha != null && senha.length > 4)
      snik.add(senha);
    else
      snik.addError(StringUtil.senhaInvalida);
  });
}

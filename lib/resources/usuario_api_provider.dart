import 'package:bloc_estudo/models/usuario.dart';

class UsuarioApiProvider {
  Future<bool> saveUsuario(Usuario usuario) async {
    await Future.delayed(Duration(seconds: 3));

    print(' Salvo: ${usuario.toMap()}');

    return true;
  }

  Future<bool> autenticarUsuario(String login, String senha) async {
    await Future.delayed(Duration(seconds: 3));

    print(' Autenticado: $login $senha');

    return true;
  }
}

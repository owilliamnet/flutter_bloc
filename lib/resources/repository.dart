import 'package:bloc_estudo/models/usuario.dart';
import 'package:bloc_estudo/resources/usuario_api_provider.dart';

class Repository {
  final usuarioApiProvider = UsuarioApiProvider();

  Future<bool> saveUsuario(Usuario usuario) =>
      usuarioApiProvider.saveUsuario(usuario);
      Future<bool> autenticarUsuario(String login, String senha) =>
      usuarioApiProvider.autenticarUsuario(login, senha);
}

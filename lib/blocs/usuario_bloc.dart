import 'dart:async';

import 'package:bloc_estudo/models/usuario.dart';
import 'package:bloc_estudo/resources/repository.dart';
import 'package:bloc_estudo/widgets/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../validators/validators.dart';

class UsuarioBloc extends Object with Validators implements BlocBase {
  Repository _repository;

  final _saveController = BehaviorSubject<bool>();
  final _loginController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();

  Sink<bool> get inSave => _saveController.sink;
  Stream<bool> get outSave => _saveController.stream;

  Sink<String> get _inLogin => _loginController.sink;
  Stream<String> get outLogin =>
      _loginController.stream.transform(loginValidator);

  Sink<String> get _inSenha => _senhaController.sink;
  Stream<String> get outSenha =>
      _senhaController.stream.transform(senhaValidator);

  Stream<bool> get submitCheck =>
      Observable.combineLatest2(outLogin, outSenha, (l, s) => true);

  Function(String) get loginChanged => _loginController.sink.add;
  Function(String) get senhaChanged => _senhaController.sink.add;

  UsuarioBloc() {
    _repository = Repository();
  }

  Future<bool> autenticarUsuario() async {
    return await _repository.autenticarUsuario(
        _loginController.value, _senhaController.value);
  }

  limparDados() {
    _loginController.value = "";
    _senhaController.value = "";
  }

  Future<bool> salvarUsuario(Usuario usuario) async {
    return await _repository.saveUsuario(usuario);
  }

  @override
  void dispose() {
    _loginController?.close();
    _senhaController?.close();
    _saveController?.close();
  }
}

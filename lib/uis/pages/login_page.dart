import 'package:bloc_estudo/blocs/usuario_bloc.dart';
import 'package:bloc_estudo/uis/pages/usuario_cadastro_page.dart';
import 'package:bloc_estudo/utils/string_util.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final UsuarioBloc usuarioBloc = UsuarioBloc();

  atualizarPagina(BuildContext context) {
    usuarioBloc.inSave.add(true);
    usuarioBloc.autenticarUsuario().then((valor) {
      usuarioBloc.inSave.add(false);
      usuarioBloc.limparDados();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => CadastroUsuarioPage()));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Bloc pattern"),
        ),
        body: _buildPaginaLogin(context),
      );

  Widget _buildPaginaLogin(BuildContext context) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<String>(
                stream: usuarioBloc.outLogin,
                builder: (context, snapshot) => _buidField(
                    StringUtil.descricaoLogin,
                    snapshot.error,
                    usuarioBloc.loginChanged),
              ),
              SizedBox(height: 20),
              StreamBuilder<String>(
                stream: usuarioBloc.outSenha,
                builder: (context, snapshot) => _buidField(
                    StringUtil.descricaoSenha,
                    snapshot.error,
                    usuarioBloc.senhaChanged),
              ),
              SizedBox(height: 20),
              StreamBuilder<bool>(
                stream: usuarioBloc.submitCheck,
                builder: (context, snapshot) =>
                    _buildButtonLogin(context, snapshot),
              ),
            ],
          ),
        ),
      );

  Container _buildButtonLogin(
          BuildContext context, AsyncSnapshot<bool> snapshot) =>
      Container(
        height: 45,
        child: RaisedButton(
          child: const Text(
            StringUtil.descricaoEntrar,
            style: TextStyle(fontSize: 20),
          ),
          onPressed: snapshot.hasData ? () => atualizarPagina(context) : null,
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          elevation: 4.0,
          splashColor: Colors.blueGrey,
        ),
      );

  TextField _buidField(
          String descricao, String erro, Function(String) fieldChanged) =>
      TextField(
        onChanged: fieldChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: descricao,
          labelText: descricao,
          errorText: erro,
        ),
      );
}

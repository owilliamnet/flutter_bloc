import 'package:bloc_estudo/blocs/usuario_bloc.dart';
import 'package:bloc_estudo/models/usuario.dart';
import 'package:bloc_estudo/utils/string_util.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioPage extends StatefulWidget {
  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final UsuarioBloc usuarioBloc = UsuarioBloc();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cadastro Usuário"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _loginController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: StringUtil.descricaoLogin,
                      labelText: StringUtil.descricaoLogin,
                    ),
                    validator: (text) {
                      if (text.isEmpty || text.length <= 4)
                        return StringUtil.loginInvalido;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: StringUtil.descricaoSenha,
                      labelText: StringUtil.descricaoSenha,
                    ),
                    validator: (text) {
                      if (text.isEmpty || text.length < 4)
                        return StringUtil.senhaInvalida;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: StringUtil.descricaoSenhaConfirmacao,
                      labelText: StringUtil.descricaoSenhaConfirmacao,
                    ),
                    validator: (valor) {
                      if (valor.isEmpty || _senhaController.text != valor)
                        return StringUtil.confirmacaoSenhaInvalida;
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 45,
                    child: RaisedButton(
                      child: const Text(
                        StringUtil.descricaoCadastrar,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          usuarioBloc
                              .salvarUsuario(Usuario(
                                  login: _loginController.text,
                                  senha: _senhaController.text))
                              .then((valor) {
                            if (valor)
                              _onSuccess(context);
                            else
                              _onFail(context);
                          });
                        }
                      },
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  void _onSuccess(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}

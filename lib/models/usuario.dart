class Usuario {
  String login;
  String senha;

  
  Usuario({this.login, this.senha});
  Usuario.fromJson(data) {
    login = data['login'];
    senha = data['senha'];
  }

  Map<String, dynamic> toMap() {
    return {
      "login": login,
      "senha": senha,
    };
  }
}

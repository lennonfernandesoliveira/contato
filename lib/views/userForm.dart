import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/providerUsers.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:string_mask/string_mask.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _dadosFormulario = {};

  void _carregarDadosAoIniciar(User user) {
    if (user != null) {
      _dadosFormulario['id'] = user.id;
      _dadosFormulario['nome'] = user.nome;
      _dadosFormulario['email'] = user.email;
      _dadosFormulario['urlImagem'] = user.urlImagem;
      _dadosFormulario['telefone'] = user.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioParaEdicao = ModalRoute.of(context).settings.arguments as User;
    var controller = new MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
    var formatter = new StringMask('(00) 00000-0000');

    _carregarDadosAoIniciar(usuarioParaEdicao);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do contato'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final eValido = _form.currentState.validate();
                if (eValido) {
                  _form.currentState.save();
                  //Lisen:false para que o provider não seja notificado
                  Provider.of<ProviderUsers>(context, listen: false).put(User(
                      id: _dadosFormulario['id'],
                      nome: _dadosFormulario['nome'],
                      email: _dadosFormulario['email'],
                      urlImagem: _dadosFormulario['urlImagem'],
                      telefone: _dadosFormulario['telefone']));
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _dadosFormulario['nome'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (value) => _dadosFormulario['nome'] = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome em branco.';
                    }

                    if (value.length > 10) {
                      return 'Nome muito grande.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                    initialValue: formatter.apply(_dadosFormulario['telefone']),
                    decoration: InputDecoration(labelText: 'Telefone'),
                    onSaved: (value) => _dadosFormulario['telefone'] = value,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [controller],
                    validator: (value) {
                      var valor = value
                          .replaceAll(" ", "")
                          .replaceAll("-", "")
                          .replaceAll("(", "")
                          .replaceAll(")", "");
                      if (valor == null || valor.isEmpty) {
                        return 'Telefone em branco.';
                      } else if (valor.length < 11) {
                        return 'Telefone inválido.';
                      }

                      return null;
                    }),
                TextFormField(
                    initialValue: _dadosFormulario['email'],
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    onSaved: (value) => _dadosFormulario['email'] = value,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-Mail em branco.';
                      }

                      if (!value.contains('@')) {
                        return 'E-Mail inválido.';
                      }

                      return null;
                    }),
                TextFormField(
                  initialValue: _dadosFormulario['urlImagem'],
                  decoration: InputDecoration(labelText: 'Url do avatar'),
                  onSaved: (value) => _dadosFormulario['urlImagem'] = value,
                )
              ],
            )),
      ),
    );
  }
}

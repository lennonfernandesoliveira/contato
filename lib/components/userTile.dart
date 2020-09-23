import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/providerUsers.dart';
import 'package:flutter_crud/routes/appRoutes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:string_mask/string_mask.dart';

class UserTile extends StatelessWidget {
  final User usuario;
  const UserTile(this.usuario);

  @override
  Widget build(BuildContext context) {
    final imagem = usuario.urlImagem == null || usuario.urlImagem.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(usuario.urlImagem));
    var maskFormatter = new MaskedTextController(
        mask: '(00) 0000-0000', text: usuario.telefone);
    var formatter = new StringMask('(00) 0000-0000');
    return ListTile(
        leading: imagem,
        title: Text(usuario.nome),
        subtitle: Column(
          children: <Widget>[
            Text(usuario.email),
            Text(formatter.apply(usuario.telefone))
          ],
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.orange[300],
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.USERFORM, arguments: usuario);
                  }),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text('Excluir contato'),
                            content: Text('Tem certeza?'),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Não')),
                              FlatButton(
                                  onPressed: () {
                                    Provider.of<ProviderUsers>(context,
                                            listen: false)
                                        .remove(usuario);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Sim'))
                            ],
                          ));
                },
              ),
            ],
          ),
        ));
  }
}

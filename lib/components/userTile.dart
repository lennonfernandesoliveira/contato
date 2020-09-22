import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/providerUsers.dart';
import 'package:flutter_crud/routes/appRoutes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User usuario;
  const UserTile(this.usuario);

  @override
  Widget build(BuildContext context) {
    final imagem = usuario.urlImagem == null || usuario.urlImagem.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(usuario.urlImagem));
    return ListTile(
        leading: imagem,
        title: Text(usuario.nome),
        subtitle: Text(usuario.email),
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
                            title: Text('Excluir usuário'),
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

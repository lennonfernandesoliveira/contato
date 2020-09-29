import 'package:flutter/material.dart';
import 'package:flutter_crud/components/userTile.dart';
import 'package:flutter_crud/provider/providerUsers.dart';
import 'package:flutter_crud/routes/appRoutes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserList extends StatefulWidget {
  @override
  _ReportDialogState createState() => new _ReportDialogState();
}

@override
_ReportDialogState createState() => new _ReportDialogState();

class _ReportDialogState extends State<UserList> {
  var newTaskCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProviderUsers users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Agenda'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_box),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.USERFORM);
            setState(() {
              newTaskCtrl = new TextEditingController();

              users.carregarSemNotificar();
            });
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        )
      ]),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextField(
                onEditingComplete: () {
                  if (newTaskCtrl.text != null && newTaskCtrl.text.isNotEmpty) {
                    setState(() {
                      users.findByName(newTaskCtrl.text);
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  } else {
                    setState(() {
                      users.carregarSemNotificar();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  }
                },
                controller: newTaskCtrl,
                decoration: InputDecoration(
                    labelText: "Procurar Contato",
                    hintText: "Informe o nome do contato",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    )),
              ),
            ),
            Divider(),
            Expanded(
                child: ListView.builder(
              itemCount: users.count,
              itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
            )),
          ],
        ),
      ),
    );
  }
}

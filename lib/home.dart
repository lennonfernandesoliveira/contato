import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/providerUsers.dart';
import 'package:flutter_crud/routes/appRoutes.dart';
import 'package:flutter_crud/views/userForm.dart';
import 'package:flutter_crud/views/userList.dart';
import 'package:provider/provider.dart';

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => ProviderUsers(),
          )
        ],
        child: MaterialApp(
          title: 'Controle de Contatos',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            AppRoutes.HOME: (BuildContext context) => UserList(),
            AppRoutes.USERFORM: (BuildContext context) => UserForm()
          },
        ));
  }
}

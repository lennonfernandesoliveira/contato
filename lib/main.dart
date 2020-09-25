import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:flutter_crud/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Contatos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeApp(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  var _title = "Pronto";
  var _message = "Toque no botão para iniciar a autenticação";
  var _icone = Icons.settings_power;
  var _colorIcon = Colors.yellow;
  var _colorButton = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controle de contatos"),
      ),
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                        child: ListTile(
                          leading: Icon(
                            _icone,
                            color: _colorIcon,
                          ),
                          title: Text(
                            _title,
                            style: TextStyle(fontSize: 30),
                          ),
                          subtitle: Text(
                            _message,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: 100,
                    height: 50, // specific value
                    child: RaisedButton(
                      color: _colorButton,
                      child: Icon(Icons.fingerprint),
                      onPressed: _checkBiometricSensor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkBiometricSensor() async {
    try {
      var authenticate = await _localAuth.authenticateWithBiometrics(
          localizedReason: 'Por favor autentique-se para continuar');

      setState(() {
        if (authenticate) {
          Navigator.of(context).pushNamed('/home');
        } else {
          _title = "Ops";
          _message = "Tente novamente!";
          _icone = Icons.clear;
          _colorIcon = Colors.red;
          _colorButton = Colors.red;
        }
      });
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        setState(() {
          _title = "Desculpe";
          _message = "Não conseguimos encontrar o sensor biométrico :(";
          _icone = Icons.clear;
          _colorIcon = Colors.red;
          _colorButton = Colors.red;
        });
      }
    }
  }
}

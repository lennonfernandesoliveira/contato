import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:flutter_crud/home.dart';

class Login extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Login> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  var titulo = "Pronto";
  var mensagem = "Toque no botão para logar através da biometria";
  var icone = Icons.settings_power;
  var corIcone = Colors.black;
  var corBotao = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Card(
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                        child: ListTile(
                          leading: Icon(
                            icone,
                            color: corIcone,
                          ),
                          title: Text(
                            titulo,
                            style: TextStyle(fontSize: 30),
                          ),
                          subtitle: Text(
                            mensagem,
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
                      color: corBotao,
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
          localizedReason: 'Favor, logar através da biometria');

      setState(() {
        if (authenticate) {
          Navigator.of(context).pushNamed('/Home');
        } else {
          titulo = "Ops";
          mensagem = "Biometria inválida!";
          icone = Icons.clear;
          corIcone = Colors.red;
          corBotao = Colors.red;
        }
      });
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        setState(() {
          titulo = "Desculpe";
          mensagem = "Sensor biométrico não encontrado :(";
          icone = Icons.clear;
          corIcone = Colors.red;
          corBotao = Colors.red;
        });
      }
    }
  }
}

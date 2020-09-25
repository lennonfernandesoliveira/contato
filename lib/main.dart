import 'package:flutter_crud/login.dart';
import 'package:flutter_crud/home.dart';
import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ]
    // Start OneSignal connection
    // OneSignal.shared.init('02d41705-3373-4da2-8c23-7e0e77f8c239');

    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);

    // OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {

    // });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
          headline6: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => Login(),
        '/Home': (context) => HomeApp(),
      },
    );
  }
}

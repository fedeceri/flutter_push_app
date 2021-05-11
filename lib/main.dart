import 'package:flutter/material.dart';
import 'package:push_app/src/pages/home_screen.dart';
import 'package:push_app/src/pages/message_screen.dart';

import 'src/services/push_notifications_service.dart';
import 'src/services/push_notifications_service.dart';

 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    PushNotificationService.messagesStream.listen((message) {
      print('My app message: $message');

      navigatorKey.currentState?.pushNamed('message',arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      home: HomePage(),
      navigatorKey: navigatorKey, //Navegar
      scaffoldMessengerKey: messengerKey , //Snacks
      routes:{
        'home': (BuildContext c) => HomePage(),
        'message': (BuildContext c) => MessageScreen()


      },
    );
  }


}
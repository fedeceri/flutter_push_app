//import 'package:firebase_messaging/firebase_messaging.dart';
//SHA1: BC:45:71:DF:35:F2:34:0A:B1:E1:72:41:85:1C:62:BD:E8:DD:C7:BB


import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController();

  static Stream<String> get messagesStream => _messageStream.stream;

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    print('Background Handler: ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    print('On Message Handler: ${message.messageId}');
    print(message.data);

    _messageStream.add(message.data['producto'] ?? 'No data');

  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('On Message Open App Handler: ${message.messageId}');
    print(message.data);

    _messageStream.add(message.data['producto'] ?? 'No data');

  }

  static Future initializeApp() async {

    //Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: '+ token.toString());
    //token: e6AiPT99Tu--HF0EEo7ZR8:APA91bEuO6191CTokiRi_lmaVKzj7PrJ-CSwr38vxXmdLDNI_8rBz_fL-dG7YP_qOWAK54pb0GrN9P3WhOPXolg9yomG3gbKdrzvCo6ikcaVI7w4_5mJNPVTztIEDECfGNUZ0y54pBpJ


    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);


    //Local notifications

  }

  static _closeStreams(){
    _messageStream.close();
  }

}
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static Future<String?> initializeAndGetToken() async {
    // Firebase 초기화
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await Firebase.initializeApp();
    // await Firebase.initializeApp(
    //     options: const FirebaseOptions(
    //         apiKey: 'AIzaSyBcCryDcWtB6Ip6aaOcTNFs56DaNkVuVeE',
    //         appId: '1:632945139972:ios:1c967774464077a90f3051',
    //         messagingSenderId: '632945139972',
    //         projectId: 'app-1-632945139972-ios-1c967774464077a90f3051'));

    // FCM 인스턴스 가져오기
    final fcmInstance = FirebaseMessaging.instance;

    // 알림 권한 요청 (iOS의 경우 필수)
    NotificationSettings settings = await fcmInstance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 디바이스 토큰 가져오기
      // String? token = await fcmInstance.getToken();
      final token = await FirebaseMessaging.instance.getAPNSToken();
      // final token = await FirebaseMessaging.instance.getToken();

      // String? token = await fcmInstance.getAPNSToken();
      print('Device Token: $token');
      return token;
    }

    return null;
  }
}

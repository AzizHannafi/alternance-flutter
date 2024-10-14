import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../utils/SharedPreferencesUtils.dart';
import '../ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FCMService {
  final ApiClient _apiClient = ApiClient();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _requestPermissions();
    await _initializeLocalNotifications();
    _configureMessageHandling();
    await _getAndSendToken();
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _configureMessageHandling() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Notification Title: ${message.notification?.title}');
      print('Notification Body: ${message.notification?.body}');

      await _showLocalNotification(message);
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Message opened app from background state!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Notification Title: ${message.notification?.title}');
      print('Notification Body: ${message.notification?.body}');
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
    );
  }

  Future<void> _getAndSendToken() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print('FCM Token: $token');
      await _sendTokenToServer(token);
    }

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('FCM Token refreshed: $newToken');
      _sendTokenToServer(newToken);
    });
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      int userId = await _getUserId();
      await addToken(userId.toString(), token);
      await _saveTokenLocally(token);
    } catch (e) {
      print('Failed to send token to server: $e');
    }
  }

  Future<int> _getUserId() async {
    await SharedPreferencesUtils.init();
    return SharedPreferencesUtils.getValue<int>("id") ?? 0;
  }

  Future<void> _saveTokenLocally(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
  }

  Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  Future<void> addToken(String userId, String token) async {
    try {
      final response = await _apiClient.dio.post("api/fcm/fcm-token",
        data: {
          "userId": userId,
          "token": token
        },
      );

      if (response.statusCode == 200) {
        print('Successfully added FCM token');
      } else {
        throw Exception('Failed to add FCM token: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add FCM token: $e');
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  print('Notification Title: ${message.notification?.title}');
  print('Notification Body: ${message.notification?.body}');
}
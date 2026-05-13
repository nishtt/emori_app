import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // ИНИЦИАЛИЗАЦИЯ
  static Future<void> init() async {
    tz.initializeTimeZones();

    try {
      final locationData = await FlutterTimezone.getLocalTimezone();
      final String timeZoneName = locationData.identifier;

      debugPrint("Final TimeZone: $timeZoneName");
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      debugPrint("Error setting timezone, falling back: $e");
      tz.setLocalLocation(tz.getLocation('Europe/Moscow'));
    }

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notifications.initialize(settings);
    //канал для андроид
    final androidPlugin =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'daily_channel_id',
        'Daily Reminders',
        importance: Importance.max,
      ),
    );
  }

  // ЗАПРОС РАЗРЕШЕНИЙ ПРИ ВКЛЮЧЕНИИ ФУНКЦИИ
  static Future<bool> requestPermissions() async {
    bool granted = true;

    // Android
    final androidPlugin =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      final notificationsGranted =
          await androidPlugin.requestNotificationsPermission();

      await androidPlugin.requestExactAlarmsPermission();

      granted = notificationsGranted ?? false;
    }

    // iOS
    final iosPlugin =
        _notifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin != null) {
      final iosGranted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      granted = iosGranted ?? false;
    }

    return granted;
  }

  // ПЛАНИРОВАНИЕ
  static Future<void> scheduleDailyNotification({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    debugPrint("Текущее время: $now");
    debugPrint("Запланировано на: $scheduledDate");

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Reminders',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: false,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ОТМЕНА ВСЕХ
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
    debugPrint("уведомления отменены");
  }

  // DEBUG
  static Future<void> printPending() async {
    final pending = await _notifications.pendingNotificationRequests();
    debugPrint("PENDING COUNT: ${pending.length}");
    for (var n in pending) {
      debugPrint("ID: ${n.id}, TITLE: ${n.title}, NEXT: ${n.payload}");
    }
  }
}
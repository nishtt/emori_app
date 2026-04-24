import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // ИНИЦИАЛИЗАЦИЯ
  static Future<void> init() async {
    tz.initializeTimeZones();
    
    try {
      // 1. Получаем объект TimezoneInfo
      final locationData = await FlutterTimezone.getLocalTimezone();
      
      // 2. В версии 5.0.2 используем поле .id
      String timeZoneName = locationData.identifier; 

      print("Final TimeZone: $timeZoneName");
      tz.setLocalLocation(tz.getLocation(timeZoneName));

    } catch (e) {
      print("Error setting timezone, falling back: $e");
      // Безопасный вариант для диплома
      tz.setLocalLocation(tz.getLocation('Europe/Moscow'));
    }

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);

    // Создаём канал
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'daily_channel_id',
        'Daily Reminders',
        importance: Importance.max,
      ),
    );
  }

  // ПЛАНИРОВАНИЕ
  static Future<void> scheduleDailyNotification({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    // ФИКС №2: Считаем время относительно локального пояса, а не UTC
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Если время уже прошло сегодня, переносим на завтра
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    print("ТЕКУЩЕЕ ВРЕМЯ (локальное): $now");
    print("ЗАПЛАНИРОВАНО НА: $scheduledDate");

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
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // ФИКС №3: Указываем, что уведомление должно повторяться ежедневно
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ЗАПРОС РАЗРЕШЕНИЙ (вызывать при старте приложения)
  static Future<void> requestPermissions() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (android != null) {
      await android.requestNotificationsPermission();
      await android.requestExactAlarmsPermission();
    }
  }

  // ОТМЕНА ВСЕХ
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
    print("Все уведомления отменены");
  }

  // DEBUG
  static Future<void> printPending() async {
    final pending = await _notifications.pendingNotificationRequests();
    print("PENDING COUNT: ${pending.length}");
    for (var n in pending) {
      print("ID: ${n.id}, TITLE: ${n.title}, NEXT: ${n.payload}");
    }
  }
}
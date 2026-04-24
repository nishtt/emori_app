# Сохраняем код плагина уведомлений
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Сохраняем ресиверы, которые отвечают за запуск уведомлений по расписанию и после перезагрузки
-keep public class com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver
-keep public class com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver

-keep class com.google.type.DateTime { *; }
-keep class com.google.type.TimeZone { *; }

-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }

-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**
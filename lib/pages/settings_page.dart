import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/pages/mood_packs_page.dart';
import 'package:mood_app/pages/themes_page.dart';
import 'package:mood_app/services/audio_provider.dart';
import 'package:mood_app/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:mood_app/components/my_alert_dialog.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:mood_app/services/locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isNotificationOn = false;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationOn = prefs.getBool('notifications_enabled') ?? false;
      int hour = prefs.getInt('notification_hour') ?? 20;
      int minute = prefs.getInt('notification_minute') ?? 0;
      _selectedTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> _saveSettings(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', enabled);
    await prefs.setInt('notification_hour', _selectedTime.hour);
    await prefs.setInt('notification_minute', _selectedTime.minute);
  }

  
  void _rescheduleNotification(AppLocalizations l10n) {
    NotificationService.scheduleDailyNotification(
      id: 1, 
      hour: _selectedTime.hour,
      minute: _selectedTime.minute,
      title: l10n.notificationTitle,
      body: l10n.notificationBody,
    );
  }

  //окно выбора времени для напоминания
  void _showScrollingTimePicker(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 1.2),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          l10n.dailyReminder,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: 200,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              initialDateTime: DateTime(2024, 1, 1, _selectedTime.hour, _selectedTime.minute),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  _selectedTime = TimeOfDay.fromDateTime(newDateTime);
                });
              },
            ),
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () async {
                await _saveSettings(true);
                _rescheduleNotification(l10n); 
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  //окно выбора языка
  void _showLanguageDialog(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectLanguage),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),  side: const BorderSide(color: Colors.black, width: 1.2)),
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, "Русский", const Locale('ru'), localeProvider),
            _buildLanguageOption(context, "English", const Locale('en'), localeProvider),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(l10n.settings, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          
          _buildSectionTitle(l10n.general),
          // язык
          _buildSettingsTile(
            icon: Icons.language_rounded,
            title: l10n.language,
            subtitle: l10n.languageSubtitle,
            onTap: () => _showLanguageDialog(context),
          ),

          _buildSectionTitle(l10n.appearance),
          //темы
          _buildSettingsTile(
            icon: Icons.palette_outlined,
            title: l10n.appTheme,
            subtitle: l10n.themeSubtitle,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemesPage()));
            },
          ),
          // паки
          _buildSettingsTile(
            icon: Icons.emoji_emotions_outlined,
            title: l10n.moodPacks,
            subtitle: l10n.moodPackSubtitle,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MoodPacksPage()));
            },
          ),

          const SizedBox(height: 20),

          // уведомления
          _buildSectionTitle(l10n.notifications),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 0.8),
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications_none_rounded),
              title: Text(l10n.dailyReminder, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(_isNotificationOn
                  ? "${l10n.dailyReminderSubtitle}: ${_selectedTime.format(context)}"
                  : l10n.dailyReminderSubtitle),
              onTap: _isNotificationOn ? () => _showScrollingTimePicker(l10n) : null,
              trailing: Switch(
                value: _isNotificationOn,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (bool value) async {
                  if (value) {
                    await NotificationService.requestPermissions();
                    _showScrollingTimePicker(l10n);
                  } else {
                    NotificationService.cancelAll(); 
                    await _saveSettings(false);
                  }
                  setState(() {
                    _isNotificationOn = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          _buildSectionTitle(l10n.account),
          //выход из аккаунта
          _buildSettingsTile(
            icon: Icons.logout_rounded,
            title: l10n.logout,
            subtitle: l10n.logoutSubtitle,
            textColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              showConfirmDialog(
                context: context,
                title: l10n.logout,
                message: l10n.logoutConfirm,
                confirmText: l10n.logout,
                cancelText: l10n.cancel,
                onConfirm: () {
                  Provider.of<AudioProvider>(context, listen: false).stopAll();
                  logout();
                },
              );
            },
          ),
        ],
      ),
    );
  }
  //виджет раздела
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
      ),
    );
  }
  //виджет настройки
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color textColor = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 0.8),
      ),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String label, Locale locale, LocaleProvider provider) {
    return ListTile(
      title: Text(label),
      trailing: provider.locale == locale ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
      onTap: () {
        provider.setLocale(locale);
        Navigator.pop(context);
      },
    );
  }
}
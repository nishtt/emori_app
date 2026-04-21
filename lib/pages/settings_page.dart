import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/pages/mood_packs_page.dart';
import 'package:mood_app/pages/themes_page.dart';
import 'package:mood_app/services/audio_provider.dart';
import 'package:provider/provider.dart';
import 'package:mood_app/components/my_alert_dialog.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:mood_app/services/locale_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  void _showLanguageDialog(BuildContext context) {
  final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
  
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.selectLanguage), // Добавь этот ключ в .arb
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
        title: Text(l10n.settings, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _buildSectionTitle(l10n.general),
          _buildSettingsTile(
          icon: Icons.language_rounded,
          title: l10n.language, // Добавь ключ language в .arb
          subtitle: l10n.languageSubtitle, // Добавь ключ languageSubtitle в .arb
          onTap: () => _showLanguageDialog(context),
          ),
          // раздел внешний вид
          _buildSectionTitle(l10n.appearance),
          //выбор темы
          _buildSettingsTile(
            icon: Icons.palette_outlined,
            title: l10n.appTheme,
            subtitle: l10n.themeSubtitle,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThemesPage()),
              );
            },
          ),
          //выбор пака
          _buildSettingsTile(
            icon: Icons.emoji_emotions_outlined,
            title: l10n.moodPacks,
            subtitle: l10n.moodPackSubtitle,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoodPacksPage()),
              );
            },
          ),

          const SizedBox(height: 20),

          // раздел напоминаний
          _buildSectionTitle(l10n.notifications),
          _buildSettingsTile(
            icon: Icons.notifications_none_rounded,
            title: l10n.dailyReminder,
            subtitle: l10n.dailyReminderSubtitle,
            onTap: () {
              // время уведомлений
            },
          ),

          const SizedBox(height: 20),

          // раздел аккаунт
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

  // виджет для заголовков разделов
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // виджет для кнопок настроек
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
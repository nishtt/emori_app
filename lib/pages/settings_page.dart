import 'package:flutter/material.dart';
import 'package:mood_app/auth/auth_service.dart';
import 'package:mood_app/pages/mood_packs_page.dart';
import 'package:mood_app/pages/themes_page.dart';
import 'package:mood_app/services/audio_provider.dart';
import 'package:provider/provider.dart';
import 'package:mood_app/components/my_alert_dialog.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          // раздел внешний вид
          _buildSectionTitle("Appearance"),
          //выбор темы
          _buildSettingsTile(
            icon: Icons.palette_outlined,
            title: "App Theme",
            subtitle: "Change colors and appearance",
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
            title: "Mood Packs",
            subtitle: "Change your emoji style",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoodPacksPage()),
              );
            },
          ),

          const SizedBox(height: 20),

          // раздел напоминаний
          _buildSectionTitle("Notifications"),
          _buildSettingsTile(
            icon: Icons.notifications_none_rounded,
            title: "Daily Reminder",
            subtitle: "Don't forget to log your mood",
            onTap: () {
              // время уведомлений
            },
          ),

          const SizedBox(height: 20),

          // раздел аккаунт
          _buildSectionTitle("Account"),
          //выход из аккаунта
          _buildSettingsTile(
            icon: Icons.logout_rounded,
            title: "Logout",
            subtitle: "Sign out of your account",
            textColor: Theme.of(context).colorScheme.primary, 
            onTap: () {
          
              showConfirmDialog(
                context: context,
                title: "Logout",
                message: "Are you sure you want to sign out?",
                confirmText: "Logout",
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
}
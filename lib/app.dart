import 'package:flutter/material.dart';
import 'package:mood_app/pages/home_page.dart';
import 'package:mood_app/pages/insights_page.dart';
import 'package:mood_app/pages/settings_page.dart';
import 'package:mood_app/pages/soundscape_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //домашняя страница
  int _selectedIndex = 1;
  //меняем вкладку
  void _navigateBottomBar (int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List <Widget> _pages = [
    SoundscapePage(),
    HomePage(),
    InsightsPage(),
    SettingsPage(),

  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [

          BottomNavigationBarItem(
            icon:Icon(Icons.music_note),
            label: 'Soundscape'
          ),

          BottomNavigationBarItem(
            icon:Icon(Icons.calendar_month),
            label: 'Home'
          ),

          BottomNavigationBarItem(
            icon:Icon(Icons.bar_chart),
            label: 'Insights'
          ),

          BottomNavigationBarItem(
            icon:Icon(Icons.settings),
            label: 'Settings'
          ),



        ]),
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_app/pages/notes_page.dart';
import 'package:mood_app/components/calendar_day_tile.dart';
import 'emote_picker_page.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:mood_app/services/entry_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EntryService _entryService = EntryService();
  final DateTime _startDate = DateTime(2020, 1);
  final DateTime _today = DateTime.now();

  late PageController _pageController;
  late int _totalMonths;
  late String _currentMonthLabel;

  StreamSubscription<QuerySnapshot>? _moodSubscription;

  // данные настроений: {'2025-07-07': 'happy'}
  Map<String, String> _moodData = {};

  @override
  void initState() {
    super.initState();

    _totalMonths =
        (_today.year - _startDate.year) * 12 +
        (_today.month - _startDate.month) +
        1;

    _pageController = PageController(initialPage: _totalMonths - 1);

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      DateTime date = DateTime(_startDate.year, _startDate.month + next);
      String newLabel = DateFormat(
        'LLLL yyyy',
        Localizations.localeOf(context).toString(),
      ).format(date);

      if (_currentMonthLabel != newLabel) {
        setState(() => _currentMonthLabel = newLabel);
      }
    });

    _listenToMoods();
  }

  //смена языка
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localeCode = Localizations.localeOf(context).languageCode;

    setState(() {
      _currentMonthLabel = DateFormat('LLLL yyyy', localeCode).format(_today);
    });
  }
  //прослушка изменений в коллекции настроений пользователя
  void _listenToMoods() {
    _moodSubscription = _entryService.watchAllEntries().listen((snapshot) {
      final Map<String, String> fetchedMoods = {};

      for (var doc in snapshot.docs) {
        fetchedMoods[doc.id] = doc.data()['moodKey'] ?? 'neutral';
      }

      if (mounted) {
        setState(() => _moodData = fetchedMoods);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentMonthLabel,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: _buildWeekDaysHeader(),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _totalMonths,
        itemBuilder: (context, index) {
          DateTime monthDate = DateTime(
            _startDate.year,
            _startDate.month + index,
          );

          return _buildMonthGrid(monthDate);
        },
      ),
    );
  }
  //сетка дней недели
  Widget _buildWeekDaysHeader() {
    final l10n = AppLocalizations.of(context)!;

    final List<String> weekDays = [
      l10n.mo,
      l10n.tu,
      l10n.we,
      l10n.th,
      l10n.fr,
      l10n.sa,
      l10n.su,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: weekDays.map((d) {
          return SizedBox(
            width: 40,
            child: Text(
              d,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  //календарная сетка
  Widget _buildMonthGrid(DateTime monthDate) {
    int daysInMonth = DateTime(monthDate.year, monthDate.month + 1, 0).day;

    int firstWeekday = DateTime(
      monthDate.year,
      monthDate.month,
      1,
    ).weekday;

    int offset = firstWeekday - 1;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 35,
        crossAxisSpacing: 10,
      ),
      itemCount: daysInMonth + offset,
      itemBuilder: (context, index) {
        if (index < offset) return const SizedBox();

        int day = index - offset + 1;

        DateTime currentDate = DateTime(
          monthDate.year,
          monthDate.month,
          day,
        );

        String dateKey = DateFormat('yyyy-MM-dd').format(currentDate);

        bool isFuture = currentDate.isAfter(_today);
        bool isToday = _isSameDay(currentDate, _today);
        String? moodKey = _moodData[dateKey];

        return CalendarDayTile(
          day: day,
          isToday: isToday,
          isFuture: isFuture,
          moodKey: moodKey,
          onTap: () => _onDayTap(currentDate),
        );
      },
    );
  }

  //нажатие на день
  void _onDayTap(DateTime date) {
    String dateKey = DateFormat('yyyy-MM-dd').format(date);
    //есть запись - к странице всех записей, нет - к выбору эмодзи
    if (_moodData.containsKey(dateKey)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotesPage(initialDate: date),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmotePickerPage(selectedDate: date),
        ),
      );
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  void dispose() {
    _moodSubscription?.cancel();
    _pageController.dispose();
    super.dispose();
  }
}
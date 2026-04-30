import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();

    _totalMonths =
        (_today.year - _startDate.year) * 12 +
        (_today.month - _startDate.month) +
        1;

    _pageController = PageController(initialPage: _totalMonths - 1);
  }

  // обновляем название месяца при смене языка
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final localeCode = Localizations.localeOf(context).languageCode;

    _currentMonthLabel = DateFormat('LLLL yyyy', localeCode).format(_today);
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

      // PageView строит календарь по месяцам
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _totalMonths,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final monthDate = DateTime(
            _startDate.year,
            _startDate.month + index,
          );

          // данные загружаются только для отображаемого месяца
          return StreamBuilder(
            stream: _entryService.watchEntriesForMonth(monthDate),
            builder: (context, snapshot) {
              final moodData = <String, String>{};

              if (snapshot.hasData) {
                for (final doc in snapshot.data!.docs) {
                  moodData[doc.id] = doc.data()['moodKey'] ?? 'neutral';
                }
              }

              return _buildMonthGrid(monthDate, moodData);
            },
          );
        },
      ),
    );
  }

  // обновление заголовка при перелистывании месяцев
  void _onPageChanged(int index) {
    final localeCode = Localizations.localeOf(context).languageCode;
    final date = DateTime(_startDate.year, _startDate.month + index);

    setState(() {
      _currentMonthLabel = DateFormat('LLLL yyyy', localeCode).format(date);
    });
  }

  // сетка дней недели
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

  // календарная сетка месяца
  Widget _buildMonthGrid(DateTime monthDate, Map<String, String> moodData) {
    final daysInMonth = DateTime(monthDate.year, monthDate.month + 1, 0).day;
    final firstWeekday = DateTime(monthDate.year, monthDate.month, 1).weekday;
    final offset = firstWeekday - 1;

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

        final day = index - offset + 1;

        final currentDate = DateTime(
          monthDate.year,
          monthDate.month,
          day,
        );

        final dateKey = DateFormat('yyyy-MM-dd').format(currentDate);

        final isFuture = currentDate.isAfter(_today);
        final isToday = _isSameDay(currentDate, _today);
        final moodKey = moodData[dateKey];

        return CalendarDayTile(
          day: day,
          isToday: isToday,
          isFuture: isFuture,
          moodKey: moodKey,
          onTap: () => _onDayTap(currentDate, moodData),
        );
      },
    );
  }

  // переход либо к существующей записи, либо к созданию новой
  void _onDayTap(DateTime date, Map<String, String> moodData) {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);

    if (moodData.containsKey(dateKey)) {
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
    _pageController.dispose();
    super.dispose();
  }
}
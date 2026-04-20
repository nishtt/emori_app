import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mood_app/components/note_card.dart';
import 'create_entry_page.dart';

class NotesPage extends StatefulWidget {
  final DateTime initialDate;

  const NotesPage({super.key, required this.initialDate});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late DateTime _currentMonth;
  // нужно ли скроллить к конкретному дню 
  bool _shouldScrollToDay = true;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  //смена месяца
  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + offset);
      //отключаем автоскролл
      _shouldScrollToDay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        //кнопка назад
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        //месяц и кнопки переключения
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () => _changeMonth(-1),
            ),
            SizedBox(
              width: 140,
              child: Text(
                DateFormat('yyyy MMMM').format(_currentMonth),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 18
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.black),
              onPressed: () => _changeMonth(1),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: Align(
          alignment: Alignment.topCenter,
          child: MonthEntriesList(
            key: ValueKey(_currentMonth.toString()), 
            month: _currentMonth,
            targetDay: _shouldScrollToDay ? widget.initialDate.day : null,
          ),
        ),
      ),
    );
  }
}

class MonthEntriesList extends StatefulWidget {
  final DateTime month;
  final int? targetDay;

  const MonthEntriesList({
    super.key,
    required this.month,
    this.targetDay,
  });

  @override
  State<MonthEntriesList> createState() => _MonthEntriesListState();
}

class _MonthEntriesListState extends State<MonthEntriesList> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final startOfMonth = DateTime(widget.month.year, widget.month.month, 1);
    final endOfMonth = DateTime(widget.month.year, widget.month.month + 1, 0, 23, 59, 59);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('entries')
          .where('date', isGreaterThanOrEqualTo: startOfMonth)
          .where('date', isLessThanOrEqualTo: endOfMonth)
          .orderBy('date', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return const Center(
            child: Text("No entries for this month", style: TextStyle(color: Colors.grey)),
          );
        }

        int initialIndex = 0;
        if (widget.targetDay != null) {
          initialIndex = docs.indexWhere((doc) {
            DateTime docDate = (doc['date'] as Timestamp).toDate();
            return docDate.day == widget.targetDay;
          });
          if (initialIndex == -1) initialIndex = 0;
        }

        return ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          initialScrollIndex: initialIndex, 
          initialAlignment: 0,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(), 
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final date = (data['date'] as Timestamp).toDate();

            return NoteCard(
              data: data,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEntryPage(
                      date: date,
                      moodKey: data['moodKey'],
                      score: data['score'],
                      initialText: data['note'],
                      isEditing: true,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
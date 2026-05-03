import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_app/l10n/app_localizations.dart';
import 'package:mood_app/services/mood_service.dart';
import 'package:mood_app/services/entry_service.dart';
import 'package:mood_app/data/activity_data.dart';
import 'package:mood_app/services/activity_localization.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  final EntryService _entryService = EntryService();
  DateTime _selectedMonth = DateTime.now();
  String _selectedMoodForActivities = 'happy';

  Color _getMoodColor(String moodKey) {
  switch (moodKey) {
    case 'happy': return Colors.amber;
    case 'calm': return Colors.lightGreen;
    case 'neutral': return const Color.fromARGB(255, 116, 240, 231);
    case 'sad': return const Color.fromARGB(255, 98, 146, 250);
    case 'angry': return Colors.redAccent;
    case 'anxious': return const Color.fromARGB(255, 158, 87, 251);
    case 'tired': return Colors.blueGrey;
    case 'lost': return const Color.fromARGB(255, 148, 121, 85);
    default: return Colors.blue;
  }
}

  // переключение месяца
  void _changeMonth(int delta) {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + delta);
    });
  }

  //подсчет активностей для всех записей месяца
  Map<String, int> _countActivities(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final Map<String, int> counts = {};

    for (final doc in docs) {
      final data = doc.data();
      final activities = List<String>.from(data['activities'] ?? []);

      for (final activityKey in activities) {
        counts[activityKey] = (counts[activityKey] ?? 0) + 1;
      }
    }

    return counts;
  }
  //подсчет активностей для записей с определенным настроением
  Map<String, int> _countActivitiesByMood(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    String moodKey,
  ) {
    final filteredDocs = docs.where((doc) {
      return doc.data()['moodKey'] == moodKey;
    }).toList();

    return _countActivities(filteredDocs);
  }

  List<MapEntry<String, int>> _sortActivityCounts(Map<String, int> counts) {
    final entries = counts.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        //стрелка назад
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => _changeMonth(-1),
        ),
        //текущий месяц
        title: Text(
          DateFormat('LLLL yyyy', localeCode).format(_selectedMonth),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        //стрелка вперед
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.black),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _getMoodStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return _buildEmptyState(l10n);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSummaryCard(docs),
              const SizedBox(height: 20),
              _buildLineChartCard(docs),
              const SizedBox(height: 20),
              _buildPieChartCard(docs),
              const SizedBox(height: 20),
              _buildActivitiesCounterCard(docs),
              const SizedBox(height: 20),
              _buildActivitiesByMoodCard(docs),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }

  // cтрим данных для конкретного месяца
  Stream<QuerySnapshot<Map<String, dynamic>>> _getMoodStream() {
    return _entryService.watchEntriesForMonth(_selectedMonth);
  }

  // 1. количество записей за месяц и средний score
  Widget _buildSummaryCard(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    double avgScore = docs.map((d) => (d.data() as Map)['score'] as int).reduce((a, b) => a + b) / docs.length;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(l10n.entries, docs.length.toString()),
          _buildStatItem(l10n.avgScore, avgScore.toStringAsFixed(1)),
        ],
      ),
    );
  }
// 2. линейный график изменения настроения + стабильность
Widget _buildLineChartCard(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  final int lastDay = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
  final l10n = AppLocalizations.of(context)!;
  
  List<FlSpot> spots = [];
  double totalChange = 0;
  
  for (int i = 0; i < docs.length; i++) {
    final data = docs[i].data();
    final date = (data['date'] as Timestamp).toDate();
    final score = (data['score'] as num).toDouble();
    
    spots.add(FlSpot(date.day.toDouble(), score));

    if (i > 0) {
      final prevScore = (docs[i - 1].data())['score'] as num;
      totalChange += (score - prevScore).abs();
    }
  }

  double stability = docs.length > 1 
    ? (1 - (totalChange / (docs.length - 1) / 4)).clamp(0, 1) * 100 
    : 100;

  return Container(
    height: 300,
    padding: const EdgeInsets.all(16),
    decoration: _cardDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                l10n.moodFlow, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                overflow: TextOverflow.ellipsis, 
              ),
            ),
            const SizedBox(width: 8), 
            Text(
              "${l10n.moodStability}: ${stability.toStringAsFixed(0)}%", 
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary, 
                fontWeight: FontWeight.bold,
                fontSize: 14, 
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: LineChart(
            LineChartData(
              minX: 1,
              maxX: lastDay.toDouble(), 
              minY: 0,
              maxY: 5,
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(
                show: true,
                border: const Border(left: BorderSide(), bottom: BorderSide()),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      if (value % 1 != 0 || value < 1 || value > lastDay) {
                        return const SizedBox.shrink();
                      }

                      final int day = value.toInt();

                      if (day == 1 || day == 10 || day == 20 || day == lastDay) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8,
                          
                          fitInside: SideTitleFitInsideData(
                            enabled: true,
                            distanceFromEdge: 0,
                            axisPosition: meta.axisPosition, 
                            parentAxisSize: meta.parentAxisSize, 
                          ),
                          child: Text(
                            day.toString(),
                            style: const TextStyle(
                              fontSize: 12, 
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  // 3. круговая диаграмма соотношения эмоций
  Widget _buildPieChartCard(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    Map<String, int> counts = {};
    for (var doc in docs) {
      String key = (doc.data() as Map)['moodKey'];
      counts[key] = (counts[key] ?? 0) + 1;
    }

    List<PieChartSectionData> sections = counts.entries.map((entry) {
      return PieChartSectionData(
        color: _getMoodColor(entry.key),
        value: entry.value.toDouble(),
        title: '${((entry.value / docs.length) * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: PieChart(PieChartData(sections: sections, centerSpaceRadius: 40)),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: counts.entries.map((e) => Row(
                children: [
                  Container(width: 10, height: 10, color: _getMoodColor(e.key)),
                  const SizedBox(width: 5),
                  Text(
                    MoodManager.getTranslation(context, e.key), 
                    style: const TextStyle(fontSize: 12)
                  ),
                ],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  //4. общий счетчик активностей
  Widget _buildActivitiesCounterCard(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final counts = _sortActivityCounts(_countActivities(docs));

    if (counts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.monthlyActivities,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 14,
            children: counts.map(_buildActivityStatItem).toList(),
          )
        ],
      ),
    );
  }

  //5. счетчик активностей для выбранного настроения
  Widget _buildActivitiesByMoodCard(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final allActivities = _countActivities(docs);

    if (allActivities.isEmpty) {
      return const SizedBox.shrink();
    }

    final counts = _sortActivityCounts(
      _countActivitiesByMood(docs, _selectedMoodForActivities),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.usuallyWithMood,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMoodForActivities,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: MoodManager.moodKeys.map((moodKey) {
                      return DropdownMenuItem(
                        value: moodKey,
                        child: Text(
                          MoodManager.getTranslation(context, moodKey),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedMoodForActivities = value;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          if (counts.isEmpty)
            Text(
              AppLocalizations.of(context)!.noActivitiesForMood,
              style: const TextStyle(color: Colors.grey),
            )
          else
            Wrap(
              spacing: 12,
              runSpacing: 14,
              children: counts.map(_buildActivityStatItem).toList(),
            )
        ],
      ),
    );

  }
  

  // вспомогательные виджеты
  //карточки
  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.black, width: 1.2),
  );
  //элемент статистики
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
  //месяц без записей
  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Text(
        l10n.noEntries, 
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
  
  Widget _buildActivityStatItem(MapEntry<String, int> entry) {
  final activity = getActivityByKey(entry.key);

  if (activity == null) {
    return const SizedBox.shrink();
  }

  return SizedBox(
    width: 70, // фиксированная ширина
    child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // КРУЖОК
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Icon(
                activity.icon,
                size: 26,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            // ЦИФРА
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  entry.value.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        // ПОДПИСЬ
        Text(
          getActivityLabel(context, entry.key),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10.5,
            height: 1.1,
          ),
        ),
      ],
    ),
  );
}
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  DateTime _selectedMonth = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
          DateFormat('MMMM yyyy').format(_selectedMonth),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _getMoodStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return _buildEmptyState();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSummaryCard(docs),
              const SizedBox(height: 20),
              _buildLineChartCard(docs),
              const SizedBox(height: 20),
              _buildPieChartCard(docs),
            ],
          );
        },
      ),
    );
  }

  // cтрим данных для конкретного месяца
  Stream<QuerySnapshot> _getMoodStream() {
    final user = FirebaseAuth.instance.currentUser;
    DateTime firstDay = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    DateTime lastDay = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('entries')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(firstDay))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(lastDay))
        .orderBy('date')
        .snapshots();
  }

  // 1. количество записей за месяц и средний score
  Widget _buildSummaryCard(List<QueryDocumentSnapshot> docs) {
    double avgScore = docs.map((d) => (d.data() as Map)['score'] as int).reduce((a, b) => a + b) / docs.length;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Entries", docs.length.toString()),
          _buildStatItem("Avg Score", avgScore.toStringAsFixed(1)),
        ],
      ),
    );
  }
// 2. линейный график изменения настроения + стабильность
Widget _buildLineChartCard(List<QueryDocumentSnapshot> docs) {
  final int lastDay = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;

  List<FlSpot> spots = [];
  double totalChange = 0;
  
  for (int i = 0; i < docs.length; i++) {
    final data = docs[i].data() as Map<String, dynamic>;
    final date = (data['date'] as Timestamp).toDate();
    final score = (data['score'] as num).toDouble();
    
    spots.add(FlSpot(date.day.toDouble(), score));

    if (i > 0) {
      final prevScore = (docs[i - 1].data() as Map<String, dynamic>)['score'] as num;
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
            const Text("Mood Flow", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("Mood stability: ${stability.toStringAsFixed(0)}%", 
                 style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
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
  Widget _buildPieChartCard(List<QueryDocumentSnapshot> docs) {
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
                Text(e.key, style: const TextStyle(fontSize: 12)),
              ],
            )).toList(),
          ),
        ),
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
  Widget _buildEmptyState() => const Center(child: Text("No entries for this month"));
}
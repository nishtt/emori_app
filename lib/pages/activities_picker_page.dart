import 'package:flutter/material.dart';
import 'package:mood_app/models/activity_item.dart';
import 'package:mood_app/l10n/app_localizations.dart';

class ActivitiesPickerPage extends StatefulWidget {
  final List<String> selectedActivities;

  const ActivitiesPickerPage({
    super.key,
    required this.selectedActivities,
  });

  @override
  State<ActivitiesPickerPage> createState() => _ActivitiesPickerPageState();
}

class _ActivitiesPickerPageState extends State<ActivitiesPickerPage> {
  late List<String> _selectedActivities;

  @override
  void initState() {
    super.initState();
    _selectedActivities = List<String>.from(widget.selectedActivities);
  }

  void _toggleActivity(String key) {
    setState(() {
      if (_selectedActivities.contains(key)) {
        _selectedActivities.remove(key);
      } else {
        _selectedActivities.add(key);
      }
    });
  }

  void _saveSelection() {
    Navigator.pop(context, _selectedActivities);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.activities,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveSelection,
            child: const Icon(
              Icons.check,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activityCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = activityCategories[categoryIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getActivityCategoryLabel(context, category.key),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final item = category.items[index];
                  final isSelected = _selectedActivities.contains(item.key);

                  return GestureDetector(
                    onTap: () => _toggleActivity(item.key),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.55),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.black,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Icon(
                                item.icon,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black,
                                size: 28,
                              ),
                            ),

                            if (isSelected)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          getActivityLabel(context, item.key),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

            ],
          );
        },
      ),
    );
  }
}
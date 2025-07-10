import 'package:flutter/material.dart';

class HorizontalDatedMonthGrid extends StatefulWidget {
  final String title;
  final int weekStartsOn;
  final int monthStartsOn;
  final int daysInMonth;

  const HorizontalDatedMonthGrid({
    super.key,
    required this.title,
    required this.weekStartsOn,
    required this.monthStartsOn,
    required this.daysInMonth,
  });

  @override
  State<HorizontalDatedMonthGrid> createState() =>
      _HorizontalDatedMonthGridState();
}

class _HorizontalDatedMonthGridState extends State<HorizontalDatedMonthGrid> {
  String getCellContent(int index) {
    if (index < 7) {
      const List<String> weekdays = [
        'Sun',
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
      ];
      return weekdays[(widget.weekStartsOn + index) % 7];
    }

    List<String> grid = List<String>.filled(42, '');
    int dateNumber = 1;
    int i = 0;

    while (dateNumber <= widget.daysInMonth) {
      if (i < 7) {
        i++;
        continue;
      } else if (i >= 7 + widget.monthStartsOn || dateNumber > 1) {
        if (dateNumber <= widget.daysInMonth) {
          grid[i] = dateNumber.toString();
          dateNumber++;
        }
      }

      i++;

      if (i > 41 && dateNumber <= widget.daysInMonth) {
        i = 7;
      }
    }

    return grid[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Calendar grid
            Expanded(
              child: Center(
                child: GridView.count(
                  crossAxisCount: 7,
                  children: List.generate(42, (index) {
                    String text = getCellContent(index);
                    final isHeader = index < 7;
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: isHeader
                            ? Colors.deepPurple[200]
                            : Colors.deepPurple[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontWeight: isHeader
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

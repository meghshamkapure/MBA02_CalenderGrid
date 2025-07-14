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
  final List<String> weekdays = ['Sun',  'Mon',  'Tue',  'Wed',  'Thu',  'Fri',  'Sat',];

  late List<String> monthGrid;

  @override
  void initState() {
    super.initState();
    monthGrid = getMonthList(widget.monthStartsOn, widget.daysInMonth);
  }

  List<String> getMonthList(int monthStartsOn, int daysInMonth) {
    const List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    int date = 1;
    List<String> grid = List<String>.filled(42, '');
    monthStartsOn = (monthStartsOn) % 7;
    for (int i = 0; i < grid.length; ) {
      //week fill
      if (i <= 6) {
        grid[i] = weekdays[i % 7];
      }
      // before month starts
      else if (i > 6 && monthStartsOn-- > 0) {
        grid[i] = '';
      }
      // filling date till end of grid
      else if (i > 6 && date <= daysInMonth) {
        grid[i] = (date++).toString();
      }
      i++;
      if ( date <= daysInMonth && i == grid.length ) {
        i = weekdays.length ;
      }
    }
    print(grid);
    return grid;
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
                children: List.generate(42, (index) {
                  final isHeader = index < 7;
                  final text = monthGrid[index];
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
          ],
        ),
      ),
    );
  }
}

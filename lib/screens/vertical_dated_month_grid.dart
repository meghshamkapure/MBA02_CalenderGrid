import 'package:flutter/material.dart';
import 'package:mba02_calender_layout_application/utility/month_grid_generator.dart';

class VerticalDatedMonthGrid extends StatefulWidget {
  final String title;
  final int weekStartsOn;
  final int monthStartsOn;
  final int daysInMonth;

  const VerticalDatedMonthGrid({
    super.key,
    required this.title,
    required this.weekStartsOn,
    required this.monthStartsOn,
    required this.daysInMonth,
  });

  @override
  State<VerticalDatedMonthGrid> createState() =>
      _VerticalDatedMonthGridState();
}

class _VerticalDatedMonthGridState extends State<VerticalDatedMonthGrid> {
  final List<String> weekdays = ['Sun',  'Mon',  'Tue',  'Wed',  'Thu',  'Fri',  'Sat',];

  late List<String> monthGrid;

  @override
  void initState() {
    super.initState();
    // Use the shared logic
    monthGrid = generateMonthGrid(widget.monthStartsOn, widget.daysInMonth);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellWidth = screenWidth / 7;
    final cellHeight = cellWidth; // for square cells; adjust if needed

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: cellHeight * 6, // 1 row for weekdays + 5 for dates = 6 total rows
          width: screenWidth,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // total 6 rows
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1, // square cells
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final isHeader = index < 7;
              final text = monthGrid[index];
              return Container(
                decoration: BoxDecoration(
                  color: isHeader ? Colors.deepPurple[200] : Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight:
                      isHeader ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

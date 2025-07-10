import 'package:flutter/material.dart';

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
  State<VerticalDatedMonthGrid> createState() => _VerticalDatedMonthGridState();
}

class _VerticalDatedMonthGridState extends State<VerticalDatedMonthGrid> {
  final List<String> weekdays = const [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // Build calendar matrix using single loop from 0 to 41
  List<List<String>> _buildVerticalGrid() {
    // Initialize 6 columns (1 header + 5 week columns)
    List<List<String>> columns = List.generate(6, (_) => List.filled(7, ''));

    int currentDate = 1;
    bool dateStarted = false;

    // Single loop from 0 to 41 (42 cells total, but we only use 6 columns)
    for (int i = 0; i < 42; i++) {
      int col = i ~/ 7; // Column index (0-5)
      int row = i % 7; // Row index (0-6)

      // Skip if we exceed our 6 columns
      if (col >= 6) break;

      if (col == 0) {
        // Column 1: Print weekdays
        columns[col][row] = weekdays[(widget.weekStartsOn + row) % 7];
      } else if (col >= 1 && col <= 4) {
        // Columns 2-5: Print dates only if month has started
        if (!dateStarted && row == widget.monthStartsOn) {
          dateStarted = true;
        }

        if (dateStarted && currentDate <= widget.daysInMonth) {
          columns[col][row] = currentDate.toString();
          currentDate++;
        }
      } else if (col == 5) {
        // Column 6: Fill remaining dates if any
        if (currentDate <= widget.daysInMonth) {
          columns[col][row] = currentDate.toString();
          currentDate++;
        }
      }
    }

    // If we still have dates left, fill empty cells from the beginning
    if (currentDate <= widget.daysInMonth) {
      for (int i = 0; i < 35 && currentDate <= widget.daysInMonth; i++) {
        // 35 = 5 weeks × 7 days
        int col = (i ~/ 7) + 1; // Skip header column
        int row = i % 7;

        // Only fill if cell is empty
        if (col < 6 && columns[col][row] == '') {
          columns[col][row] = currentDate.toString();
          currentDate++;
        }
      }
    }

    print(columns);
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> verticalGrid = _buildVerticalGrid();
    final int numColumns =
        verticalGrid.length; // 7 columns (1 header + 6 week columns)

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: List.generate(numColumns, (colIndex) {
              return Container(
                width: 60,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  children: List.generate(7, (rowIndex) {
                    final isHeader = colIndex == 0;
                    return Container(
                      height: 40,
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: isHeader
                            ? Colors.deepPurple[200]
                            : Colors.deepPurple[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          verticalGrid[colIndex][rowIndex],
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
              );
            }),
          ),
        ),
      ),
    );
  }
}

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

  List<List<String>> _buildVerticalGrid() {
    List<List<String>> columns = List.generate(6, (_) => List.filled(7, ''));

    int currentDate = 1;
    bool dateStarted = false;
    bool wrapAround = false;
    int wrapStartIndex = 7;

    for (int i = 0; i < 84; i++) {
      int col, row;

      if (!wrapAround) {
        col = i ~/ 7;
        row = i % 7;

        if (col >= 6) {
          if (currentDate <= widget.daysInMonth) {
            wrapAround = true;
            i = wrapStartIndex - 1;
            continue;
          } else {
            break;
          }
        }
      } else {
        int adjustedIndex = i - wrapStartIndex;
        if (adjustedIndex >= 35) break;

        col = (adjustedIndex ~/ 7) + 1;
        row = adjustedIndex % 7;
      }

      if (col == 0) {
        columns[col][row] = weekdays[(widget.weekStartsOn + row) % 7];
      } else {
        if (wrapAround) {
          if (columns[col][row] == '' && currentDate <= widget.daysInMonth) {
            columns[col][row] = currentDate.toString();
            currentDate++;
          }
        } else {
          if (!dateStarted && row == widget.monthStartsOn) {
            dateStarted = true;
          }

          if (dateStarted && currentDate <= widget.daysInMonth) {
            columns[col][row] = currentDate.toString();
            currentDate++;
          }
        }
      }

      if (currentDate > widget.daysInMonth) {
        break;
      }
    }

    print(columns);
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    final List<List<String>> verticalGrid = _buildVerticalGrid();
    final int numColumns = verticalGrid.length;

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

import 'package:flutter/material.dart';
import 'package:mba02_calender_layout_application/screens/horizontal_dated_month_grid.dart';
import 'package:mba02_calender_layout_application/screens/vertical_dated_month_grid.dart';

class CalendarInputForm extends StatefulWidget {
  const CalendarInputForm({super.key});

  @override
  State<CalendarInputForm> createState() => _CalendarInputFormState();
}

class _CalendarInputFormState extends State<CalendarInputForm> {
  final _formKey = GlobalKey<FormState>();

  int _weekStartsOn = 0; // hidden from UI
  int _monthStartsOn = 0;
  int _daysInMonth = 31;
  String _layoutType = 'horizontal'; // default selected

  final List<String> _weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final Map<String, String> _layoutOptions = {
    'horizontal': 'Horizontal Layout',
    'vertical': 'Vertical Layout',
  };

  void _generateCalendar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Widget destination;

      if (_layoutType == 'vertical') {
        destination = VerticalDatedMonthGrid(
          title: 'Vertical Calendar',
          weekStartsOn: _weekStartsOn,
          monthStartsOn: _monthStartsOn,
          daysInMonth: _daysInMonth,
        );
      } else {
        destination = HorizontalDatedMonthGrid(
          title: 'Horizontal Calendar',
          weekStartsOn: _weekStartsOn,
          monthStartsOn: _monthStartsOn,
          daysInMonth: _daysInMonth,
        );
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calendar Configuration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Layout Selector
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Layout:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _layoutType,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: _layoutOptions.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _layoutType = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Month Starts On
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Month Starts:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<int>(
                          value: _monthStartsOn,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: List.generate(7, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(_weekdays[index]),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              _monthStartsOn = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Days in Month
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Days in Month:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: _daysInMonth.toString(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            hintText: 'Enter days (28-31)',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter number of days';
                            }
                            int? days = int.tryParse(value);
                            if (days == null || days < 28 || days > 31) {
                              return 'Please enter a valid number between 28-31';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            int? days = int.tryParse(value ?? '');
                            if (days != null) {
                              _daysInMonth = days;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Generate Button
                ElevatedButton(
                  onPressed: _generateCalendar,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Generate Calendar'),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

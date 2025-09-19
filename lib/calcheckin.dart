import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class checkin extends StatefulWidget {
  final TabController tabController;
  final Function(DateTime?) onDateSelected;
  checkin({required this.tabController, required this.onDateSelected});
  @override
  _checkinState createState() => _checkinState();
}

class _checkinState extends State<checkin> {
  DateTime? _selectedDay;

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Select'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // Calendars inside Expanded to allow scrolling
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCalendarSection(
                      'September 2025',
                      DateTime(2025, 9, 15),
                    ),
                    _buildCalendarSection(
                      'October 2025',
                      DateTime(2025, 10, 15),
                    ),
                    _buildCalendarSection(
                      'November 2025',
                      DateTime(2025, 11, 15),
                    ),
                  ],
                ),
              ),
            ),
            // Apply button at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onDateSelected(_selectedDay);
                    widget.tabController.animateTo(1);
                  },
                  // () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             checkout(selectedDate: _selectedDay)),
                  //   );
                  // },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300], // Disabled look
                    foregroundColor: Colors.white, // White text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ), // White text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection(String title, DateTime focusedDay) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: focusedDay, // Different for each month
              headerVisible: false,
              calendarFormat: CalendarFormat.month,
              daysOfWeekVisible: true,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.black),
                outsideDaysVisible: false, // Hides days from other months
              ),
            ),
          ],
        ),
      ),
    );
  }
}

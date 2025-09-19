import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class checkout extends StatefulWidget {
  final TabController tabController;
  final Function(DateTime?) onDatesSelected;

  final DateTime? selectedDate;
  checkout({
    required this.selectedDate,
    super.key,
    required this.tabController,
    required this.onDatesSelected,
  });
  @override
  _checkoutState createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  late final DateTime _fixedCheckInDate =
      widget.selectedDate ?? DateTime(2025, 9, 3); // Always September 3
  DateTime? _selectedDay;
  String? _roomGuestSelection; // Room & Guest section remains empty ("-")
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Select', style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.black),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSimpleInfoBox(),
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
            _buildApplyButton(), // Fixed Apply button
          ],
        ),
      ),
    );
  }

  /// Box containing Check-in, Check-out & Room & Guests (Scrolls with Calendar)
  Widget _buildSimpleInfoBox() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Check in", _fixedCheckInDate), // Always Sept 3
          _buildInfoRow("Check out", null), // No date preselected for Check-out
          _buildRoomsGuestsRow(), // Room & Guest section (empty "-")
        ],
      ),
    );
  }

  /// Row inside the scrolling box for Check-in & Check-out
  Widget _buildInfoRow(String title, DateTime? selectedDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            selectedDate != null
                ? DateFormat('MMM d, yyyy').format(
                  selectedDate,
                ) // Displays selected date
                : "-",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  /// **Room & Guest Section (Initially Empty `"-"`)**
  Widget _buildRoomsGuestsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Room & Guest",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            _roomGuestSelection ?? "-", // Always remains "-"
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  /// Scrollable Calendar Section (September 3 pre-marked, but other dates selectable)
  Widget _buildCalendarSection(String title, DateTime focusedDay) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black),
        ),
        elevation: 3,
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
              focusedDay: focusedDay,
              headerVisible: false,
              calendarFormat: CalendarFormat.month,
              daysOfWeekVisible: true,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day) ||
                    isSameDay(day, _fixedCheckInDate);
              }, // ✅ September 3 is always highlighted
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(selectedDay, _fixedCheckInDate)) {
                  setState(() {
                    _selectedDay =
                        selectedDay; // ✅ Allows other date selections
                  });
                }
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.black),
                outsideDaysVisible: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fixed Apply Button at the Bottom (Grey Background)
  Widget _buildApplyButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            widget.onDatesSelected(_selectedDay);
            widget.tabController.animateTo(2);
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300], // ✅ Changed to Grey
            foregroundColor: Colors.black, // Text color stays black
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Apply',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ), // Text in Black
        ),
      ),
    );
  }
}

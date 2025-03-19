import 'package:flutter/material.dart';
import 'package:hotelbookingapp/selectedroom.dart';
import 'package:intl/intl.dart';

class RoomGuestScreen extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? selectedCheckoutDate;
  RoomGuestScreen({
    required this.selectedDate,
    super.key,
    required this.selectedCheckoutDate,
  });
  @override
  _RoomGuestScreenState createState() => _RoomGuestScreenState();
}

class _RoomGuestScreenState extends State<RoomGuestScreen> {
  int guestCount = 0; // Guests count (0 by default)

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildInfoBox(), // Check-in, Check-out, Room & Guest Section
                  _buildRoomGuestSelection(), // Room & Guest Counter Section
                  _buildAddRoomButton(), // Add Room Button
                ],
              ),
            ),
          ),
          _buildApplyButton(), // Apply Button (Stays fixed at the bottom)
        ],
      ),
    );
  }

  /// **Check-in, Check-out & Room & Guest Section**
  Widget _buildInfoBox() {
    final dateFormat = DateFormat('yyyy-MM-dd'); // Example: 03/09/2025

    String checkIn =
        widget.selectedDate != null
            ? dateFormat.format(widget.selectedDate!)
            : "-";
    String checkOut =
        widget.selectedCheckoutDate != null
            ? dateFormat.format(widget.selectedCheckoutDate!)
            : "-";

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
          _buildInfoRow("Check in", checkIn),
          _buildInfoRow("Check out", checkOut),
          _buildInfoRow(
            "Room & guest",
            guestCount > 0 ? "$guestCount Guests" : "",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }

  /// **Room & Guest Selection**
  Widget _buildRoomGuestSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Room 1",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Guest $guestCount", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 10),
              _buildCounterRow("Adults"),
            ],
          ),
        ),
      ),
    );
  }

  /// **Counter for Guests**
  Widget _buildCounterRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Ages 5 or above",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            _buildCounterButton(false), // Decrease button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                guestCount.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ),
            _buildCounterButton(true), // Increase button
          ],
        ),
      ],
    );
  }

  /// **Increment & Decrement Buttons**
  Widget _buildCounterButton(bool isIncrement) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isIncrement && guestCount == 0) {
            guestCount = 1; // Max 1 guest
          } else {
            guestCount = 0; // Min 0 guest
          }
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color:
              isIncrement
                  ? Colors.grey[800]
                  : Colors.white, // "+" button is dark grey
          borderRadius: BorderRadius.circular(8), // Rounded square edges
          border: Border.all(color: Colors.black),
        ),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          size: 18,
          color: isIncrement ? Colors.white : Colors.black, // "+" icon is white
        ),
      ),
    );
  }

  /// **Add Room Button**
  Widget _buildAddRoomButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50, // Same height as Apply button
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            side: BorderSide(color: Colors.black),
          ),
          child: Text(
            "Add room",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }

  /// **Apply Button (Fixed at Bottom)**
  Widget _buildApplyButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed:
              guestCount > 0
                  ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            ((context) => selroom(
                              recCheckin: widget.selectedDate,
                              recCheckout: widget.selectedCheckoutDate,
                            )),
                      ),
                    );
                  }
                  : null, // Disabled when guestCount = 0
          style: ElevatedButton.styleFrom(
            backgroundColor:
                guestCount > 0
                    ? Colors.black
                    : Colors.grey[300], // Changes color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Apply',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

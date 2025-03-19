import 'package:flutter/material.dart';
import 'package:hotelbookingapp/calcheckin.dart';
import 'package:hotelbookingapp/calcheckout.dart';
import 'package:hotelbookingapp/roomandguest.dart';

class datetabbar extends StatefulWidget {
  const datetabbar({super.key});

  @override
  State<datetabbar> createState() => _datetabbarState();
}

class _datetabbarState extends State<datetabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? _selectedDate;
  DateTime? _checkoutDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleDateSelected(DateTime? date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleDatesSelected(DateTime? checkoutdate) {
    setState(() {
      _checkoutDate = checkoutdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: "Check in"),
            Tab(text: "Check out"),
            Tab(text: "Room & guest"),
          ],
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          checkin(
            tabController: _tabController,
            onDateSelected: _handleDateSelected,
          ),
          checkout(
            tabController: _tabController,
            onDatesSelected: _handleDatesSelected,
            key: ValueKey(_selectedDate),
            selectedDate: _selectedDate,
          ),
          RoomGuestScreen(
            selectedDate: _selectedDate,
            selectedCheckoutDate: _checkoutDate,
          ),
        ],
      ),
    );
  }
}

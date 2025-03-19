import 'package:flutter/material.dart';
import 'package:hotelbookingapp/mybookinghistory.dart';
import 'package:hotelbookingapp/mybookings.dart';

class tabbr extends StatefulWidget {
  const tabbr({super.key});

  @override
  State<tabbr> createState() => _tabbrState();
}

class _tabbrState extends State<tabbr> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Bookings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            tabs: [Tab(text: "Booked"), Tab(text: "History")],
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(children: [mybook(), bookhistory()]),
      ),
    );
  }
}

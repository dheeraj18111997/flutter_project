import 'package:flutter/material.dart';
import 'package:hotelbookingapp/bookinghome.dart';
import 'package:hotelbookingapp/mybookingtabbar.dart';
import 'package:hotelbookingapp/profile.dart';
import 'package:hotelbookingapp/reward.dart';

class botnav extends StatefulWidget {
  const botnav({super.key});

  @override
  State<botnav> createState() => _botnavState();
}

int indexnum = 0;
List tabwidgets = [bookhomepg(), tabbr(), rewardpg(), profilepg()];

class _botnavState extends State<botnav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Bookings"),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_sharp),
            label: "Reward",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: indexnum,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        onTap: (int index) {
          setState(() {
            indexnum = index;
          });
        },
      ),
      body: tabwidgets[indexnum],
    );
  }
}

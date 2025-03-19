import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mybook extends StatefulWidget {
  const mybook({super.key});

  @override
  State<mybook> createState() => _mybookState();
}

class _mybookState extends State<mybook> {
  Map<String, dynamic>? selectedHotel;
  String? checkin;
  String? checkout;

  // Function to load selected hotel data from SharedPreferences
  Future<void> loadSelectedHotel() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedHotel = {
        'himage': prefs.getString('himage'),
        'hloc': prefs.getString('hloc'),
        'hdesc': prefs.getString('hdesc'),
        'hprice': prefs.getString('hprice'),
        'hname': prefs.getString('hname'),
      };
    });
    print(selectedHotel);
  }

  Future<void> loadBookingDates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      checkin = prefs.getString('checkin');
      checkout = prefs.getString('checkout');
    });
    print("Loaded checkin: $checkin, checkout: $checkout");
  }

  @override
  void initState() {
    super.initState();
    loadSelectedHotel();
    loadBookingDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 150,
                              child:
                                  selectedHotel != null &&
                                          selectedHotel!['himage'] != null
                                      ? Image.network(
                                        selectedHotel!['himage'],
                                        fit: BoxFit.fill,
                                      )
                                      : Container(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Text('No image available'),
                                        ),
                                      ),
                              //  Image.asset(
                              //   "asset/bookhotel4.jpg",
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,

                                children: [
                                  Text(
                                    selectedHotel!['hname'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Location ${selectedHotel!['hloc']}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "₹${selectedHotel!['hprice']}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, size: 15),
                                      Text(
                                        "   4.5",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "    (999)",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 1000,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Check in",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  checkin ?? 'notset',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_circle_right_outlined, size: 40),
                            Column(
                              children: [
                                Text(
                                  "Check out",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  checkout ?? 'notset',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

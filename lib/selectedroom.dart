import 'package:flutter/material.dart';
import 'package:hotelbookingapp/booked_hotel.dart';
import 'package:hotelbookingapp/datetabbar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selroom extends StatefulWidget {
  final DateTime? recCheckin;
  final DateTime? recCheckout;
  selroom({super.key, required this.recCheckin, required this.recCheckout});

  @override
  State<selroom> createState() => _selroomState();
}

class _selroomState extends State<selroom> {
  Map<String, dynamic>? selectedHotel;

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

  late String formattedCheckin;
  late String formattedCheckout;

  @override
  void initState() {
    super.initState();
    loadSelectedHotel();
    final dateFormat = DateFormat("yyyy-MM-dd");
    formattedCheckin =
        widget.recCheckin != null
            ? dateFormat.format(widget.recCheckin!)
            : "2025-01-01";
    formattedCheckout =
        widget.recCheckout != null
            ? dateFormat.format(widget.recCheckout!)
            : "2025-01-02";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Kochi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.close),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => datetabbar())),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            formattedCheckin,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            "Check in",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      VerticalDivider(width: 1, color: Colors.white),
                      Column(
                        children: [
                          Text(
                            formattedCheckout,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            "Check out",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      VerticalDivider(width: 1, color: Colors.white),
                      Column(
                        children: [
                          Text(
                            "1 Room",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            "1 Guest",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Sort by"), Icon(Icons.sort)],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  height: 40,
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Filter"), Icon(Icons.filter_list)],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        ((context) => BookedHotel(
                          recCheckin: formattedCheckin,
                          recCheckout: formattedCheckout,
                        )),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: double.infinity,
                      height: 200,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "70%OFF",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, size: 12),
                    Text("  4.5", style: TextStyle(fontSize: 12)),
                    Text(
                      "    (999)",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12, color: Colors.orange),
                    Text(
                      selectedHotel!['hloc'],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(selectedHotel!['hdesc'], style: TextStyle(fontSize: 14)),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "₹${selectedHotel!['hprice']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  " ₹24,99",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

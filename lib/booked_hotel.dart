import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedHotel extends StatefulWidget {
  final String recCheckin;
  final String recCheckout;

  BookedHotel({super.key, required this.recCheckin, required this.recCheckout});
  List<Image> image = [
    Image.asset("asset/bookhotel1.png", fit: BoxFit.fill),
    Image.asset("asset/bookhotel3.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel4.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel5.jpg", fit: BoxFit.fill),
  ];

  @override
  State<BookedHotel> createState() => _BookedHotelState();
}

class _BookedHotelState extends State<BookedHotel> {
  final Dio dio = Dio();
  String _message = "";
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

  Future<void> saveBookingDates() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checkin', widget.recCheckin!);
    await prefs.setString('checkout', widget.recCheckout!);
    print(
      "Saved checkin: ${widget.recCheckin}, checkout: ${widget.recCheckout}",
    );
  }

  @override
  void initState() {
    super.initState();
    loadSelectedHotel();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> ratings = [0.2, 0.1, 0.3, 0.7, 0.9];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 310,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      selectedHotel != null && selectedHotel!['himage'] != null
                          ? NetworkImage(selectedHotel!['himage'])
                          : AssetImage("asset/hotelbuilding.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: CircleAvatar(
                            radius: 15,

                            child: Image.asset("asset/crown.png"),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            "726 Photos and videos  ──>",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedHotel!['hname'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.star, size: 15),
                  Text(" 4.2 (523 ratings) "),
                  Text(" 76 reviews", style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
            Text("   5.0 Check-in rating > ${selectedHotel!['hdesc']}"),
            SizedBox(height: 15),
            Divider(height: 1),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.orange),
                      Text(selectedHotel!['hloc']),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      child: Text("Map", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Divider(height: 1),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 100,
                width: double.infinity,

                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Check in     :     ${widget.recCheckin}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Check out     :     ${widget.recCheckout}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Room & guest     :     1 Guests",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "  Why book this?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text("    Rated high for cleanliness"),
            Divider(height: 1),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹${selectedHotel!['hprice']}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(" ₹2,499", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        bookHotel();
                        saveBookingDates();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      child: Text(
                        "Book now and Pay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " About this hotel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "OYO 16968 Better Inn is a budget hotel with standardised amenities at the best value. Our hotel is located in Kochi, with 13 km from Wonderla Amusement Park, Kochi, 6 km from Subhash Bose Park Ernakulam",
              ),
            ),
            Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " Ratings and reviews",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "  Ratings & Reviews",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text("   Top reviews from India", style: TextStyle(fontSize: 14)),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int starCount = 5 - index; // From 5 stars to 1 star
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Stars
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < starCount
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.yellow[700],
                              size: 20,
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        // Progress bar
                        Expanded(
                          child: LinearProgressIndicator(
                            value:
                                ratings[index], // Progress value for this rating
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.yellow[700]!,
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    child: Image.asset("asset/user.png"),
                                  ),
                                  Text("  Magnito"),
                                ],
                              ),
                              Container(
                                height: 20,
                                width: 30,

                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 10,
                                    ),
                                    Text(
                                      "4.2",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "I booked in agoda, so I got it cheap and I was amazed with the services offered ac room, Android TV connected, and with wifi. All this included in just 980/-......cleanliness wasn't the best as you could expect from a mid range Oyo rooms but overall for a solo business trip it was a good experience.",
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " Similar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 350,
                        width: 200,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    child: widget.image[index],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                            Row(
                              children: [
                                Icon(Icons.star, size: 12),
                                Text("  4.5", style: TextStyle(fontSize: 12)),
                                SizedBox(width: 20),
                                Text(
                                  "(999)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            Text(
                              "soothing master bedroom",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                                Text(
                                  "Location",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "₹399",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " ₹2,499",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: widget.image.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  Future<void> bookHotel() async {
    String url = "https://hotel.b4production.com/getandpostbookings";

    // Creating FormData
    FormData formData = FormData.fromMap({
      'hname': selectedHotel!['hname'] ?? "default name",
      'hostel_loc': selectedHotel!['hloc'] ?? "default location",
      'hostel_price': selectedHotel!['hprice'] ?? "D Price",
      'hostel_image': selectedHotel!['himage'] ?? "D image",
      'checkin': widget.recCheckin,
      'checkout': widget.recCheckout,
    });

    print("Request Data: ${formData.fields}");

    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json", // Accept JSON response
          },
        ),
      );

      print("Response Data: ${response.data}");

      if (response.statusCode == 201) {
        setState(() {
          _message = response.data["message"] ?? "Booking Successful!";
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_message)));
      } else {
        setState(() {
          _message = "Error: ${response.statusCode}";
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_message)));
      }
    } catch (e) {
      if (e is DioException) {
        print("Dio Error: ${e.response?.data}");
        print("Status Code: ${e.response?.statusCode}");
        print("Request Data: ${e.requestOptions.data}");
        print("Request Headers: ${e.requestOptions.headers}");
      }

      setState(() {
        _message = "Failed to book. Please try again.";
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_message)));

      print("Exception: $e");
    }
  }
}

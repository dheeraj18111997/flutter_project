import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotelbookingapp/kochirooms.dart';

class bookhomepg extends StatefulWidget {
  bookhomepg({super.key});
  List<Image> image = [
    Image.asset("asset/bookhotel1.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel2.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel3.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel4.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel5.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel6.jpg", fit: BoxFit.fill),
  ];
  List<Image> image2 = [
    Image.asset("asset/lv1.png", fit: BoxFit.fill),
    Image.asset("asset/lv2.png", fit: BoxFit.fill),
  ];

  @override
  State<bookhomepg> createState() => _bookhomepgState();
}

class _bookhomepgState extends State<bookhomepg> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchHostel();
  }

  void fetchHostel() async {
    Dio dio = Dio();
    String apiUrl = "https://hotel.b4production.com/getandposthostel";

    try {
      Response response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        setState(() {
          users = response.data;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Booking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Container(
              height: 18,
              width: 40,
              child: Center(
                child: Text(
                  ".com",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 153, 51, 1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
        actions: [Icon(Icons.notifications_none, size: 50)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                height: 40,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on, color: Colors.orange),
                    ),
                    Text("Kochi,Kerala", style: TextStyle(fontSize: 14)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Hello Akshay!", style: TextStyle(fontSize: 16)),
                  Icon(Icons.waving_hand_sharp, color: Colors.orange),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Let's find the best hotels",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "around the world",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: ((context) => roompg())),
                  );
                },
                decoration: InputDecoration(
                  hintText: "        27th Feb - 28th     1 Guest",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.search), Text("  Kochi")],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              Text(
                "Offers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: users.length > 6 ? 6 : users.length,
                  //users.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var user = users[index];
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
                                    //Image.network(
                                    //user["himage"],
                                    //fit: BoxFit.fill,
                                    //),
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
                            Text(user["hdesc"], style: TextStyle(fontSize: 14)),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: Colors.orange,
                                ),
                                Text(
                                  user["hloc"],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "₹${user["hprice"]}",
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
                ),
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: widget.image2.length,
                  itemBuilder: (context, index) {
                    return Container(height: 200, child: widget.image2[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class bookhistory extends StatefulWidget {
  bookhistory({super.key});
  List<Image> image = [
    Image.asset("asset/bookhotel1.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel2.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel3.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel4.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel5.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel6.jpg", fit: BoxFit.fill),
  ];

  @override
  State<bookhistory> createState() => _bookhistoryState();
}

class _bookhistoryState extends State<bookhistory> {
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
      body: ListView.builder(
        itemCount: users.length > 6 ? 6 : users.length,
        //users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 260,
              width: 1050,
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
                              child: widget.image[index],
                              // Image.network(
                              //user["himage"],
                              // fit: BoxFit.fill,
                              //),
                              // Image.asset(
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
                                    user["hname"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Location ${user["hloc"]}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "₹${user["hprice"]}",
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
                                Text("12 June", style: TextStyle(fontSize: 22)),
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
                                Text("12 June", style: TextStyle(fontSize: 22)),
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
          );
        },
      ),
    );
  }
}

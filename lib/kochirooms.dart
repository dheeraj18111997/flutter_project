import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotelbookingapp/datetabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class roompg extends StatefulWidget {
  roompg({super.key});
  List<Image> image = [
    Image.asset("asset/bookhotel1.png", fit: BoxFit.fill),
    Image.asset("asset/bookhotel3.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel4.jpg", fit: BoxFit.fill),
    Image.asset("asset/bookhotel5.jpg", fit: BoxFit.fill),
  ];

  @override
  State<roompg> createState() => _roompgState();
}

class _roompgState extends State<roompg> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
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

  Future<void> saveSelectedHotel(Map<String, dynamic> hotel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('himage', hotel['himage']);
    await prefs.setString('hloc', hotel['hloc']);
    await prefs.setString('hdesc', hotel['hdesc']);
    await prefs.setString('hname', hotel['hname']);
    await prefs.setString('hprice', hotel['hprice'].toString());
    print('Hotel data saved to SharedPreferences');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                height: 50,
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
                        Text("Check in", style: TextStyle(color: Colors.white)),
                        VerticalDivider(width: 1, color: Colors.white),
                        Text(
                          "Check out",
                          style: TextStyle(color: Colors.white),
                        ),
                        VerticalDivider(width: 1, color: Colors.white),
                        Text("1 Guest", style: TextStyle(color: Colors.white)),
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
              SizedBox(height: 30),
              Container(
                height: 500,
                child: ListView.builder(
                  itemCount: users.length,
                  scrollDirection: Axis.vertical,

                  itemBuilder: (context, index) {
                    var user = users[index];
                    return Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Save the selected hotel data without navigating
                              saveSelectedHotel({
                                'himage': user['himage'],
                                'hloc': user['hloc'],
                                'hdesc': user['hdesc'],
                                'hprice': user['hprice'],
                                'hname': user['hname'],
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => datetabbar()),
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
                                    child: Image.network(
                                      user["himage"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
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
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
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
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(user["hdesc"], style: TextStyle(fontSize: 14)),
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
                                " ₹24,99",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    );
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

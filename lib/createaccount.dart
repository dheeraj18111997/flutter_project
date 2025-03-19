import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotelbookingapp/bottom_nav.dart';

class accountpg extends StatefulWidget {
  const accountpg({super.key});

  @override
  State<accountpg> createState() => _accountpgState();
}

class _accountpgState extends State<accountpg> {
  var txtcontrolname = TextEditingController();
  var txtcontrolnumber = TextEditingController();
  var txtcontrolemail = TextEditingController();
  final Dio dio = Dio();
  String _message = "";
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(height: 15),
              Text(
                "Create account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("asset/user.png"),
                  ),

                  Positioned(
                    right: 15,
                    bottom: 0,
                    child: FloatingActionButton.small(
                      backgroundColor: Colors.orange,
                      onPressed: () {},
                      child: Icon(Icons.add),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "   Name",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    TextSpan(
                      text: " *",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              TextField(
                controller: txtcontrolname,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 50),
              TextField(
                controller: txtcontrolnumber,
                decoration: InputDecoration(
                  label: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Mobile number",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: " *",
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                  hintText: "9436229245",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.check_circle_outline_outlined,
                    color: Colors.green,
                  ),
                  prefixIcon: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("asset/icons8-india-48.png"),
                        Text("+91 "),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VerticalDivider(width: 1),
                        ),
                      ],
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "   Email ID",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    TextSpan(
                      text: " *",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: txtcontrolemail,
                decoration: InputDecoration(
                  hintText: "abcd123@gmail.com",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue!;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "I would like to receive marketing offers and",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "promotional communications from Booking.com.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 500,
                  height: 40,
                  child: ElevatedButton(
                    onPressed:
                        value
                            ? () {
                              registerUser();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: ((context) => botnav()),
                              //   ),
                              // );
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: value ? Colors.orange : Colors.grey,
                    ),
                    // ButtonStyle(
                    //   backgroundColor: MaterialStatePropertyAll(Colors.orange),
                    // ),
                    child: Text(
                      "Create account",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    const String url = "https://hotel.b4production.com/getandpostreg";
    FormData formData = FormData.fromMap({
      "username": txtcontrolname.text,
      "phone": txtcontrolnumber.text,
      "email": txtcontrolemail.text,
      "password": "123456",
      "image": "defaultimg",
    });
    try {
      Response response = await dio.post(url, data: formData);
      print("response  is ======== $response");
      if (response.statusCode == 200) {
        setState(() {
          _message = response.data["message"] ?? "Registration successful";
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_message)));
        Timer(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => botnav())),
          );
        });
      } else {
        setState(() {
          _message = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _message = "Failed to register, please try again";
      });
      print("Exception: $e");
    }
  }
}

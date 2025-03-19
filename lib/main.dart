import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelbookingapp/booked_hotel.dart';

import 'package:hotelbookingapp/bookinghome.dart';
import 'package:hotelbookingapp/bottom_nav.dart';
import 'package:hotelbookingapp/calcheckin.dart';
import 'package:hotelbookingapp/calcheckout.dart';
import 'package:hotelbookingapp/createaccount.dart';
import 'package:hotelbookingapp/datetabbar.dart';
import 'package:hotelbookingapp/kochirooms.dart';
import 'package:hotelbookingapp/mybookinghistory.dart';
import 'package:hotelbookingapp/mybookings.dart';
import 'package:hotelbookingapp/mybookingtabbar.dart';
import 'package:hotelbookingapp/profile.dart';
import 'package:hotelbookingapp/reward.dart';
import 'package:hotelbookingapp/roomandguest.dart';
import 'package:hotelbookingapp/selectedroom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BouncingContainer(),
    );
  }
}

class BouncingContainer extends StatefulWidget {
  @override
  _BouncingContainerState createState() => _BouncingContainerState();
}

class _BouncingContainerState extends State<BouncingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 1.5), // Start from bottom (off-screen)
      end: Offset(0, 0), // Stop at center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => secondScreen()),
      );
    }); // Start animation when screen loads
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _animation,
          // child: Container(
          //   width: 100,
          //   height: 100,
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   alignment: Alignment.center,
          //   child: Text("Bounce!", style: TextStyle(color: Colors.white)),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Booking",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 30,
                width: 60,
                child: Center(
                  child: Text(
                    ".com",
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 153, 51, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class secondScreen extends StatefulWidget {
  const secondScreen({super.key});

  @override
  State<secondScreen> createState() => _secondScreenState();
}

class _secondScreenState extends State<secondScreen> {
  List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  var txtcontrolphone = TextEditingController();
  final Dio dio = Dio();
  String _message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Booking",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              Container(
                height: 30,
                width: 60,
                child: Center(
                  child: Text(
                    ".com",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 153, 51, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200),
              Text("Welcome to", style: TextStyle(fontSize: 32)),
              Text("Booking.com", style: TextStyle(fontSize: 32)),
              Text("Get ₹2000 off when you sign up!"),
              SizedBox(height: 40),
              TextField(
                controller: txtcontrolphone,
                decoration: InputDecoration(
                  hintText: "Enter mobile number",
                  border: OutlineInputBorder(),
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
              Center(
                child: SizedBox(
                  width: 500,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: registerUser,
                    // _showOTPBottomSheet,
                    // () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: ((context) => accountpg())),
                    //   );
                    // },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.orange),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 500,
                  height: 40,
                  child: ElevatedButton(
                    onPressed:
                    // _showOTPBottomSheet,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: ((context) => accountpg())),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.orange),
                    ),
                    child: Text(
                      "create account",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text("or login with"),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      child: Image.asset("asset/icons8-google-48.png"),
                      radius: 25,
                    ),
                  ),
                  SizedBox(width: 40),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      child: Image.asset("asset/icons8-facebook-48.png"),
                      radius: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text("Continue as guest"),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showOTPBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SizedBox(
            height: 300,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (RawKeyEvent event) {
                if (event is RawKeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  _handleBackspace(context);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter OTP",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 60,
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            if (value.length == 1) {
                              if (index < 3) {
                                FocusScope.of(context).nextFocus();
                              } else {
                                FocusScope.of(context).unfocus();
                                _verifyOTP();
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _verifyOTP,
                    child: const Text(
                      "Verify OTP",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(_clearFields);
  }

  void _handleBackspace(BuildContext context) {
    // Find which field currently has focus
    for (int i = 0; i < focusNodes.length; i++) {
      if (focusNodes[i].hasFocus) {
        if (controllers[i].text.isEmpty && i > 0) {
          // Move to previous field if current is empty
          FocusScope.of(context).requestFocus(focusNodes[i - 1]);
          controllers[i - 1].clear();
        } else if (i > 0) {
          // Clear current and move to previous if not empty
          controllers[i].clear();
          FocusScope.of(context).requestFocus(focusNodes[i - 1]);
        }
        break;
      }
    }
  }

  void _verifyOTP() {
    String otp = controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      print('Entered OTP: $otp');
      // Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => botnav())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter complete OTP')),
      );
    }
  }

  void _clearFields() {
    for (var controller in controllers) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> registerUser() async {
    const String url = "https://hotel.b4production.com/getandpostlog";
    FormData formData = FormData.fromMap({
      "phone": txtcontrolphone.text,
      "password": "123456",
    });
    try {
      Response response = await dio.post(url, data: formData);
      print("response is ============== $response");
      if (response.statusCode == 201) {
        print("Response: ${response.data}");
        setState(() {
          _message = response.data["message"] ?? "Login successful";
        });
        _showOTPBottomSheet();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: ((context) => botnav())),
        // );
      } else {
        setState(() {
          _message = "Error: ${response.statusCode}";
        });
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(_message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        _message = "Failed to login, please try again";
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(_message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      print("Exception: $e");
      if (e is DioException) {
        print('DioException details:');
        print('Message: ${e.message}');
        print('Response: ${e.response}');
        print('Error: ${e.error}');
      }
    }
  }
}

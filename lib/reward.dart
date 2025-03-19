import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class rewardpg extends StatefulWidget {
  const rewardpg({super.key});

  @override
  State<rewardpg> createState() => _rewardpgState();
}

class _rewardpgState extends State<rewardpg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text("   Reward",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 15),
            Text("   Invite & Earn",style: TextStyle(fontSize: 20),),
            SizedBox(height: 15),
            Container(
              height: 500,
              color: Colors.orange,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: 70,
                        dashColor: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(radius: 20, backgroundColor: Colors.white),
                        Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("  Step 1",style: TextStyle(color: Colors.white),),
                              SizedBox(height: 5),
                              Text("  You refer Booking.com app to your",style: TextStyle(color: Colors.white),),
                              Text("  freind and they signup",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: 70,
                        dashColor: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(radius: 20, backgroundColor: Colors.white),
                        Container(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("  Step 2",style: TextStyle(color: Colors.white),),
                              SizedBox(height: 5),
                              Text("  When they check out for 1st time",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: 70,
                        dashColor: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: 70,
                            dashColor: Colors.white,
                          ),
                        ),
                        Text("You get",style: TextStyle(color: Colors.white),),Text(" 400 Rupee Offer",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: 70,
                        dashColor: Colors.white,
                      ),
                    ),
                     Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: 70,
                            dashColor: Colors.white,
                          ),
                        ),
                        Column(
                          children: [
                            Text("Your freind gets",style: TextStyle(color: Colors.white),),Text(" 400 Rupee Offer",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80),
            Center(
              child: SizedBox(height: 40,width: 500,
                child: ElevatedButton(onPressed: (){}, 
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                child: Text("Invite and Earn",style: TextStyle(color: Colors.white),),),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

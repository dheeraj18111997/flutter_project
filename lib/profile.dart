import 'package:flutter/material.dart';

class profilepg extends StatefulWidget {
  profilepg({super.key});
  List<String> details = [
    "Feedback",
    "Privacy and policy",
    "Terms and conditions",
    "Help",
    "About",
    "Change language",
    "Contact us",
  ];

  @override
  State<profilepg> createState() => _profilepgState();
}

class _profilepgState extends State<profilepg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "   Account",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("asset/user.png"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "   Akshay",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "   +91 8137850967",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              //height: 345,
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(widget.details[index]),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return Divider(height: 1);
                }),
                itemCount: widget.details.length,
              ),
            ),
            Divider(height: 1),
          ],
        ),
      ),
    );
  }
}

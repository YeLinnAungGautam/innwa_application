import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.black54),
                        ),
                        RobotoText(
                            fontSize: 18.0,
                            fontColor: Colors.black54,
                            fontWeight: FontWeight.bold,
                            text: "My Account")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RobotoText(
                          fontSize: 30.0,
                          fontColor: Colors.indigo,
                          text: "Profile",
                          fontWeight: FontWeight.bold),
                      TextButton(
                          onPressed: () {},
                          child: RobotoText(
                              fontSize: 15.0,
                              fontColor: Colors.black,
                              text: "Edit Profile"))
                    ],
                  ),
                ),
                GestureDetector(
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Version 1.4 build on Feb 4"),
                    ));
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://preview.redd.it/komi-san-bug-eyes-cat-ears-blush-heavenly-combination-v0-z67rgh9zif791.png?width=640&crop=smart&auto=webp&s=c20cd81f9e7d42b6f0f2d00646c72a8f11dc32e1"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.indigo),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RobotoText(
                              fontSize: 16.0,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              text: "ID"),
                          Container(
                            width: 200,
                            child: RobotoText(
                                fontSize: 16.0,
                                fontColor: Colors.white,
                                text: "123456676"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RobotoText(
                          fontSize: 16.0,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                          text: "Name"),
                      Container(
                        width: 200,
                        child: RobotoText(
                            fontSize: 16.0,
                            fontColor: Colors.black,
                            text: "Komi Shoko"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RobotoText(
                          fontSize: 16.0,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                          text: "D.O.B"),
                      Container(
                        width: 200,
                        child: RobotoText(
                            fontSize: 16.0,
                            fontColor: Colors.black,
                            text: "10 Matrch 2000"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RobotoText(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.black,
                          text: "Email"),
                      Container(
                          width: 200,
                          alignment: Alignment.centerLeft,
                          child: RobotoText(
                              fontSize: 16.0,
                              fontColor: Colors.black,
                              text: "komisan123@gmail.com"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RobotoText(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.black,
                          text: "Address"),
                      Container(
                        width: 200,
                        child: RobotoText(
                            fontSize: 16.0,
                            fontColor: Colors.black,
                            maxLine: 2,
                            text: "Sample Street, Road, Tsp, City"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      RobotoText(
                        fontSize: 15.0,
                        fontColor: Colors.black,
                        text: "Registration Date",
                        fontWeight: FontWeight.bold,
                      ),
                      RobotoText(
                          fontSize: 12.0,
                          fontColor: Colors.black,
                          text: "10th September 2022")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

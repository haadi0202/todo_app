//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        // main column
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //upper part
          Column(
            //top column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  //rating & social media links
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        //rating
                        "4.8",
                        style: TextStyle(
                            fontSize: 70,
                            fontFamily: "bigFont",
                            letterSpacing: 2,
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      // social media button group
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.facebook),
                          style: ButtonStyle(
                              iconSize: WidgetStatePropertyAll(30),
                              iconColor:
                                  WidgetStatePropertyAll(Colors.red[700])),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.twitter),
                          style: ButtonStyle(
                              iconSize: WidgetStatePropertyAll(30),
                              iconColor:
                                  WidgetStatePropertyAll(Colors.red[700])),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 163,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "AVERAGE DAILY TASKS COMPLETED OVER THE PAST 30 DAYS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: "bigFont",
                      ),
                    )),
              )
            ],
          ),
          //bottom part
          Column(
              //bottom column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // exit app icon
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.red[700],
                        ))
                  ],
                ),
                Container(
                  // productivity
                  width: double.infinity,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
                    child: Text(
                      "PRODUCTIVITY",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "bigFont",
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  // calender
                  width: double.infinity,
                  color: Colors.black,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/calender"),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        "CALENDER",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "bigFont",
                            letterSpacing: 1,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  // settings
                  width: double.infinity,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 50),
                    child: Text(
                      "SETTINGS",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "bigFont",
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ])
        ],
      )),
    );
  }
}

//ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/pages/taskView.dart';
import 'package:todo_app/utility/utility.dart';
import 'package:todo_app/pages/dialogue.dart';

DateTime today =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
DateTime myselectedDay = today;
late DateTime myfocusedDay;
late int numberOfTasks;
TextEditingController controller = TextEditingController(text: "");
Map<DateTime?, List> dateTimeToListOfTasks = {};

class Calender extends StatefulWidget {
  const Calender({super.key});
  @override
  State<Calender> createState() => CalenderState();
}

class CalenderState extends State<Calender> {
  CalenderState() {
    today = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    myselectedDay = today;
    myfocusedDay = today;
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    numberOfTasks = updateNumberOfTasks();

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                //calender label
                "CALENDER  ${myfocusedDay.year}",
                style: TextStyle(
                    fontFamily: "bigFont", fontSize: 20, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //table_calender
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: myfocusedDay,
                pageJumpingEnabled: true,
                daysOfWeekHeight: 40, //dont touch this
                //calender style
                calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    selectedDecoration: BoxDecoration(
                        color: Colors.red[700], shape: BoxShape.circle)),
                //header style
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  rightChevronVisible: false,
                  leftChevronVisible: false,
                  titleTextStyle: TextStyle(
                      fontFamily: "big",
                      color: Colors.red[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                  titleTextFormatter: (date, locale) {
                    return returnMonthByMonthNumber(date.month);
                  },
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(myselectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  //ondayselected method
                  setState(() {
                    myselectedDay = selectedDay;
                    myfocusedDay =
                        focusedDay; // update `_focusedDay` here as well
                    showNoOfTasks();
                  });
                },
                //onPage changed
                onPageChanged: (focusedDay) {
                  setState(() {
                    myfocusedDay = focusedDay;
                  });
                },
                //construct visually mark days
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    if (dateTimeToListOfTasks.containsKey(day)) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.solidCircle,
                                size: 5, color: Colors.red[700]),
                            Text("${day.day}",
                                style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5)
                          ]);
                    } else {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${day.day}",
                                style: TextStyle(color: Colors.white)),
                            SizedBox(height: 5)
                          ]);
                    }
                  },
                  // construct weekdays
                  dowBuilder: (context, day) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(returnWeekDayByWeekNumber(day.weekday),
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container(color: Colors.white, height: 2)
                        ]);
                  },
                ),
              ),
            ),
            //go see task button
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (numberOfTasks != 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Taskview(refresh: refresh)));
                      }
                    },
                    child: Text("$numberOfTasks TASKS",
                        style: TextStyle(
                            fontFamily: "bigFont",
                            fontSize: 30,
                            color: numberOfTasks != 0
                                ? Colors.white
                                : Colors.grey)),
                  ),
                  Icon(FontAwesomeIcons.chevronRight, color: Colors.red)
                ],
              ),
            ),
            //ass and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    //addbutton
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => CustomDialogueWidget(
                                showNoOfTasks: showNoOfTasks,
                                setStateForParent: setState,
                                //context: context
                              ));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.red[700]),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(CircleBorder())),
                    child: Icon(Icons.add)),
                TextButton(
                    //crossbutton
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        foregroundColor:
                            WidgetStatePropertyAll(Colors.red[700]),
                        shape: WidgetStatePropertyAll(CircleBorder())),
                    child: Icon(FontAwesomeIcons.xmark))
              ],
            )
          ],
        )));
  }
}

int updateNumberOfTasks() {
  if (!dateTimeToListOfTasks.containsKey(myselectedDay)) {
    return 0;
  } else {
    return dateTimeToListOfTasks[myselectedDay]!.length;
  }
}

void showNoOfTasks() {
  if (!dateTimeToListOfTasks.containsKey(myselectedDay)) {
    numberOfTasks = 0;
  } else {
    numberOfTasks = dateTimeToListOfTasks[myselectedDay]!.length;
  }
}

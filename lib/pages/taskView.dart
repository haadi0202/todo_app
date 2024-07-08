//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/utility/utility.dart';
import 'package:todo_app/pages/calender.dart';
import 'package:todo_app/pages/dialogue.dart';

// ignore: must_be_immutable
class Taskview extends StatefulWidget {
  Function refresh;
  Taskview({super.key, required this.refresh});

  @override
  // ignore: no_logic_in_create_state
  State<Taskview> createState() => TaskViewState(refresh: refresh);
}

class TaskViewState extends State<Taskview> {
  Function refresh;
  TaskViewState({required this.refresh}) {
    sort();
  }
  String title = () {
    if (myselectedDay ==
        DateTime.utc(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
      return "TODAY";
    } else if (myselectedDay == DateTime.now().add(Duration(days: 1))) {
      return "TOMMOROW";
    }
    return "${returnMonthByMonthNumber(myselectedDay.month)}, ${myselectedDay.day}";
  }();

  void deleteTask(Task task) {
    dateTimeToListOfTasks[myselectedDay]!.remove(task);
    if (dateTimeToListOfTasks[myselectedDay]!.isEmpty) {
      dateTimeToListOfTasks.remove(myselectedDay);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Task deleted"),
      backgroundColor: Colors.red[700],
      duration: Duration(milliseconds: 500),
    ));
    refresh();
    setState(() {});
  }

  void markTask(Task task) {
    int index = dateTimeToListOfTasks[myselectedDay]!.indexOf(task);
    dateTimeToListOfTasks[myselectedDay]![index].marked = true;
    setState(() {});
  }

  void unmarkTask(Task task) {
    int index = dateTimeToListOfTasks[myselectedDay]!.indexOf(task);
    dateTimeToListOfTasks[myselectedDay]![index].marked = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Theme(
          data: ThemeData(canvasColor: Colors.red[700]),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TASKS TODO
                Text(
                    dateTimeToListOfTasks.containsKey(myselectedDay)
                        ? "TASKS TODO - ${dateTimeToListOfTasks[myselectedDay]!.length}"
                        : "NO TASKS LEFT",
                    style: TextStyle(
                        fontFamily: "big",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 50),
                //title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontFamily: "big",
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "(${returnWeekDayByWeekNumberFull(myselectedDay.weekday)})",
                          style: TextStyle(
                              fontFamily: "big",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ],
                ),
                //sizeBox
                SizedBox(
                  height: 20,
                ),
                //list view
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: (ismyselectedDayPreesentInMap())
                        ? ReorderableListView.builder(
                            itemCount:
                                dateTimeToListOfTasks[myselectedDay]!.length,
                            itemBuilder: (context, index) {
                              return listViewRow(
                                  singleTask: dateTimeToListOfTasks[
                                      myselectedDay]![index],
                                  markTask: markTask,
                                  deleteTask: deleteTask,
                                  unmarkTask: unmarkTask,
                                  context: context);
                            },
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (newIndex ==
                                    dateTimeToListOfTasks[myselectedDay]!
                                        .length) {
                                  newIndex =
                                      dateTimeToListOfTasks[myselectedDay]!
                                              .length -
                                          1;
                                  Task movingTask =
                                      dateTimeToListOfTasks[myselectedDay]!
                                          .removeAt(oldIndex);
                                  dateTimeToListOfTasks[myselectedDay]!
                                      .insert(newIndex, movingTask);
                                  return;
                                }
                                if (newIndex == -1) {
                                  newIndex = 0;
                                }
                                if (oldIndex < newIndex) {
                                  Task movingTask =
                                      dateTimeToListOfTasks[myselectedDay]!
                                          .removeAt(oldIndex);
                                  dateTimeToListOfTasks[myselectedDay]!
                                      .insert(newIndex - 1, movingTask);
                                } else if ((oldIndex > newIndex)) {
                                  Task movingTask =
                                      dateTimeToListOfTasks[myselectedDay]!
                                          .removeAt(oldIndex);
                                  dateTimeToListOfTasks[myselectedDay]!
                                      .insert(newIndex, movingTask);
                                }
                              });
                            },
                          )
                        : Text("")),
                //sizedBox
                SizedBox(
                  height: 20,
                ),
                //ass and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        //addbutton
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CustomDialogueWidget(
                                    showNoOfTasks: showNoOfTasks,
                                    setStateForParent: setState,
                                    //context: context
                                  ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.red[700]),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shape: WidgetStatePropertyAll(CircleBorder())),
                        child: Icon(Icons.add)),
                    TextButton(
                        //crossbutton
                        onPressed: () {
                          dateTimeToListOfTasks.containsKey(myselectedDay)
                              ? sort()
                              : true;
                          Navigator.pop(context, true);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.red[700]),
                            shape: WidgetStatePropertyAll(CircleBorder())),
                        child: Icon(FontAwesomeIcons.xmark))
                  ],
                )
              ],
            ),
          )),
        ));
  }
}

Widget listViewRow(
    {required Task singleTask,
    required markTask,
    required deleteTask,
    required unmarkTask,
    required BuildContext context}) {
  Offset startOffset = Offset.zero;
  Offset endOffset = Offset.zero;

  return Padding(
      key: ObjectKey(singleTask),
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onDoubleTap: () {
            //doubleTap
            unmarkTask(singleTask);
          },
          onHorizontalDragStart: (details) =>
              startOffset = details.localPosition,
          onHorizontalDragUpdate: (details) =>
              endOffset = details.localPosition,
          onHorizontalDragEnd: (details) {
            if (startOffset.dx > endOffset.dx) {
              // Left Swipe
              deleteTask(singleTask);
            } else {
              // Right Swipe
              markTask(singleTask);
            }
          },
          child: Text(singleTask.description,
              style: singleTask.marked
                  ? TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2)
                  : TextStyle(color: Colors.white, fontSize: 18))));
}

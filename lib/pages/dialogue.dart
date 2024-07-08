//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_app/pages/calender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/utility/utility.dart';

class CustomDialogueWidget extends StatefulWidget {
  dynamic setStateForParent;
  dynamic showNoOfTasks;
  CustomDialogueWidget(
      {super.key, required this.setStateForParent, required showNoOfTasks});

  @override
  State<StatefulWidget> createState() =>
      CustomDialogueWidgetState(setStateForParent: setStateForParent);
}

class CustomDialogueWidgetState extends State<CustomDialogueWidget> {
  dynamic setStateForParent;

  CustomDialogueWidgetState({required this.setStateForParent});

  @override
  Widget build(BuildContext context) {
    return customDialogueWidget(
        showNoOfTasks: showNoOfTasks,
        setStateForParent: setStateForParent,
        context: context,
        setState: setState);
  }
}

Widget customDialogueWidget(
    {required showNoOfTasks,
    required setStateForParent,
    required context,
    required setState}) {
  return Dialog(
    backgroundColor: Colors.grey[900],
    child: Container(
      height: 350,
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.circlePlus, color: Colors.red[700], size: 30),
          SizedBox(
            height: 20,
          ),
          Text(
              "Add a task for ${returnMonthByMonthNumber(myselectedDay.month)}, ${myselectedDay.day}",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    width: 80,
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text("Task#${updateNumberOfTasks() + 1}: ",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                myTextBox(),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    donePressed(
                        showNoOfTasks: showNoOfTasks,
                        setStateForParent: setStateForParent,
                        setState: setState);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red[700])),
                  child: Text("Done", style: TextStyle(color: Colors.white))),
              OutlinedButton(
                  onPressed: () {
                    //on cancel
                    //reverse();
                    controller.clear();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      side:
                          WidgetStatePropertyAll(BorderSide(color: Colors.red)),
                      padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 15))),
                  child:
                      Text("back", style: TextStyle(color: Colors.red[700]))),
            ],
          )
        ],
      ),
    ),
  );
}

Widget myTextBox() {
  return TextField(
    maxLength: 100,
    minLines: 2,
    maxLines: 3,
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
  );
}

void donePressed(
    {required showNoOfTasks, required setStateForParent, required setState}) {
  DateTime key = myselectedDay;
  String description = controller.text;
  if (description.isEmpty) {
    return;
  }
  if (!dateTimeToListOfTasks.containsKey(key)) {
    List<Task> tasks = [];
    tasks.addAtEnd(Task(description: description, marked: false));
    dateTimeToListOfTasks.addAll({key: tasks});
  } else {
    dateTimeToListOfTasks[key]!
        .addAtEnd(Task(description: description, marked: false));
  }
  showNoOfTasks();
  setStateForParent(() {});
  setState(() {});
  controller.clear();
}

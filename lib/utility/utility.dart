import 'package:todo_app/pages/calender.dart';

String returnWeekDayByWeekNumberFull(int day) {
  Map<int, String> map = {
    1: "Sunday",
    2: "Monday",
    3: "Tuesday",
    4: "Wednesday",
    5: "Thursday",
    6: "Friday",
    7: "Saturday"
  };
  return map[day]!;
}

String returnWeekDayByWeekNumber(int day) {
  Map<int, String> map = {
    1: "S",
    2: "M",
    3: "T",
    4: "W",
    5: "T",
    6: "F",
    7: "S"
  };
  return map[day]!;
}

String returnMonthByMonthNumber(int day) {
  Map<int, String> map = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  return map[day]!;
}

void sort() {
  for (var i = 0; i < dateTimeToListOfTasks[myselectedDay]!.length; i++) {
    if (dateTimeToListOfTasks[myfocusedDay]![i].marked == true) {
      Task task = dateTimeToListOfTasks[myfocusedDay]!.removeAt(i);
      dateTimeToListOfTasks[myfocusedDay]!.add(task);
    }
  }
}

class Task {
  String description;
  bool marked;
  Task({required this.description, required this.marked});
  @override
  String toString() {
    return description;
  }
}

void reverse() {
  dateTimeToListOfTasks[myselectedDay] =
      dateTimeToListOfTasks[myselectedDay]!.reversed.toList();
}

bool ismyselectedDayPreesentInMap() {
  return dateTimeToListOfTasks[myselectedDay] != null;
}

extension atEnd on List {
  void addAtEnd(Task item) {
    if (length == 0) {
      add(item);
      return;
    }
    List<Task> list = [...this];
    print(length);
    for (var i = 0; i < length; i++) {
      removeAt(i);
      i--;
    }
    add(item);
    addAll(list);
  }
}

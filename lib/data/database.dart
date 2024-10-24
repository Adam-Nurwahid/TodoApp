import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  final _myBox = Hive.box('myBox'); // Pastikan box sudah dibuka di main()

  // Data awal jika belum ada data
  void createIntialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false]
    ];
  }

  // Load data dari Hive
  void loadData() {
    toDoList = _myBox.get("TODOLIST", defaultValue: []);
  }

  // Update Hive database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

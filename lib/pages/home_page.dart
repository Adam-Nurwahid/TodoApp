import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/dialog_box.dart';
import 'package:to_do_app/util/title.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState()  => _HomePageState();
}

class _HomePageState extends State<HomePage>{
    final _myBox = Hive.box('myBox');
    ToDoDatabase db = ToDoDatabase();

    @override
    void initState(){
      if (_myBox.get("TODOLIST") == null ){
         db.createIntialData();
      }else{
        db.loadData();
      }
      super.initState();
    }
    final _controller = TextEditingController();


  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask(){
    showDialog(context: context,
        builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
        }
        );
  }
 void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDatabase();
 }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      title: const Text('TO DO'),
        elevation: 0,//bayangan
      ) ,
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add),


      ),
      body: ListView.builder(
    itemCount: db.toDoList.length,
    itemBuilder: (context, index){
      return ToDoTile(
          taskName: db.toDoList[index][0],
          taskCompleted: db.toDoList[index][1],
          onChanged: (value) => checkBoxChanged(value, index),
        deleteFunction: (context) => deleteTask(index),
      );
    },
    )
    );
  }

}
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_w_bloc_flutter/data/models/isar_todo.dart';
import 'package:todo_w_bloc_flutter/data/repository/isar_todo_repo.dart';
import 'package:todo_w_bloc_flutter/domain/repository/todo_repo.dart';
import 'package:todo_w_bloc_flutter/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();
  //open isar db
  final isar = await Isar.open(
    [TodoIsarSchema],
    directory: dir.path,
  );
  //initialize repo with isar db
  final isarTodoRepo = IsarTodoRepo(isar);
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  //db injection throught the app
  final TodoRepo todoRepo;
  const MyApp({
    super.key,
    required this.todoRepo,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}

/*
ISAR TO DO Model

Converts Todo model into isar model so that we can store in isar db.

*/

import 'package:isar/isar.dart';
import 'package:todo_w_bloc_flutter/domain/models/todo.dart';
//to generate isar_todo object. dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  //convert isar object to pure todo object to use in app
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  //convert pure todo object to isar object to store in DB.
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
    /*
    cascade operator. 
    final languageProvider = LanguageProvider()..setLocale(locale);
    // Alternative without Cascade Operator:
    final languageProvider = LanguageProvider();
    languageProvider.setLocale(locale);
    */
  }
}

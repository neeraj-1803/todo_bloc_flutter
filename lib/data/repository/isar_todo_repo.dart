/*
DATABASE REPO

This implements the todo repo and handles storing, retrieving, updating and deleting in the isar db.
*/

import 'package:isar/isar.dart';
import 'package:todo_w_bloc_flutter/data/models/isar_todo.dart';
import 'package:todo_w_bloc_flutter/domain/models/todo.dart';
import 'package:todo_w_bloc_flutter/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  //DB object
  final Isar db;
  IsarTodoRepo(this.db);

  @override
  Future<void> addTodo(Todo newTodo) async {
    //convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);
    //write this into isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

  @override
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.todoIsars.where().findAll();
    //return as a list of todo and give to domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    //convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);
    //it will update this into isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
}

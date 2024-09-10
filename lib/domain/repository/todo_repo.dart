/*
TO DO Repository.
to define what the todo app does.
it outlines what information the app can do not the implementation details.

This is the DOMAIN layer. It is supposed to be techonolgy agnostic. doesn't matter if we decide to change the DB or any other related tech later, it won't impact the Domain layer. the abstract functionality remain the same.
*/

import 'package:todo_w_bloc_flutter/domain/models/todo.dart';

abstract class TodoRepo {
  //get list of todos
  Future<List<Todo>> getTodos();

  //add a new todo task
  Future<void> addTodo(Todo newTodo);

  //update an existing todo
  Future<void> updateTodo(Todo todo);

  //delete a todo task
  Future<void> deleteTodo(Todo todo);
}

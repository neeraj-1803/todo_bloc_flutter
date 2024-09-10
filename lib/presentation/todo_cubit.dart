/*
Each cubit is list of todos
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_w_bloc_flutter/domain/models/todo.dart';
import 'package:todo_w_bloc_flutter/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  //reference todo repo
  final TodoRepo todoRepo;

  //constructor intializes the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //load
  Future<void> loadTodos() async {
    //fetch the list from repo.
    final todoList = await todoRepo.getTodos();
    //emit the fetched list as the new state
    emit(todoList);
  }

  //add
  Future<void> addTodo(String text) async {
    //create new todo with unique id
    final newTodo = Todo(
      id: DateTime.now().microsecondsSinceEpoch,
      text: text,
    );
    await todoRepo.addTodo(newTodo);
    //reload todos
    loadTodos();
  }

  //delete
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    //reload
    loadTodos();
  }

  //toggle
  Future<void> toggleTodo(Todo todo) async {
    //toggle the todo
    final updatedTodo = todo.toggleCompletion();

    //update the todo in repo
    await todoRepo.updateTodo(updatedTodo);
    //reload
    loadTodos();
  }
}

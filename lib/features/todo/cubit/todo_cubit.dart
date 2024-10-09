import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/models/todo_models.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState());

  void addTask(Todo todo) {
    final newTodos = [...state.todos, todo];
    emit(TodoState(todos: newTodos));
  }

  void removeTask(String id) {
    final newTodos = state.todos.where((todo) => todo.id != id).toList();
    emit(TodoState(todos: newTodos));
  }

  void updateTask(Todo todo) {
    final updatedTodo =
        state.todos.map((t) => t.id == todo.id ? todo : t).toList();
    emit(TodoState(todos: updatedTodo));
  }

  void getTasks() {
    emit(state.copyWith(todos: state.todos));
  }
}

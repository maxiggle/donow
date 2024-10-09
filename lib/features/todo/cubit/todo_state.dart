part of 'todo_cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    this.todos = const [],
  });

  final List<Todo> todos;

  @override
  List<Object?> get props => [todos];

  TodoState copyWith({
    List<Todo>? todos,
  }) {
    return TodoState(todos: todos ?? this.todos);
  }
}

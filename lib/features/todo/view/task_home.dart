import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/cubit/todo_cubit.dart';
import 'package:todo/features/todo/models/todo_models.dart';

class TaskHome extends StatelessWidget {
  const TaskHome({super.key});
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: _TaskHome(),
    );
  }
}

class _TaskHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    context.read<TodoCubit>().getTasks();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Home'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return state.todos.isEmpty
              ? const Center(child: Text('No Task at the moment'))
              : ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return Dismissible(
                      key: Key(state.todos[index].id),
                      onDismissed: (direction) {
                        context.read<TodoCubit>().removeTask(todo.id);
                      },
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: state.todos[index].status
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                )
                              : const TextStyle(),
                        ),
                        subtitle: Text(
                          todo.description,
                          style: state.todos[index].status
                              ? const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                )
                              : const TextStyle(),
                        ),
                        trailing: Checkbox.adaptive(
                          value: state.todos[index].status,
                          onChanged: (value) {
                            context.read<TodoCubit>().updateTask(
                                  state.todos[index].copyWith(
                                    status: value,
                                  ),
                                );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskModal(
            context,
            titleController,
            descriptionController,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

String randomId() {
  return Random().nextInt(1000000000).toString();
}

void _taskModal(
  BuildContext context,
  TextEditingController descriptionController,
  TextEditingController titleController,
) {
  showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(5),
      ),
    ),
    builder: (BuildContext providerContext) {
      return Padding(
        padding: EdgeInsets.only(
          top: 50,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter Task Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter Task Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  context.read<TodoCubit>().addTask(
                        Todo(
                          title: titleController.text,
                          description: descriptionController.text,
                          id: randomId(),
                          date: DateTime.now(),
                        ),
                      );
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class Todo {
  const Todo({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
    this.status = false,
  });
  final String title;
  final String description;
  final String id;
  final bool status;
  final DateTime date;

  Todo copyWith({
    String? title,
    String? description,
    String? id,
    bool? status,
    DateTime? date,
  }) =>
      Todo(
        title: title ?? this.title,
        description: description ?? this.description,
        id: id ?? this.id,
        status: status ?? this.status,
        date: date ?? this.date,
      );
}

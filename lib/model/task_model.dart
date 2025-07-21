enum Category { work, personal, shopping, other }

class Task {
  final String id;
  final String title;
  final String content;
  final Category category;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? content,
    Category? category,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/task_provider.dart'; 
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class EditScreen extends ConsumerStatefulWidget {
  final Task task;

  EditScreen({super.key, required this.task});

  @override
  ConsumerState<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    contentController = TextEditingController(text: widget.task.content);
    selectedCategory = widget.task.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<Category>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items:
                  Category.values.map((category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(
                        category.name[0].toUpperCase() +
                            category.name.substring(1),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final updatedTask = Task(
                  id: widget.task.id,
                  title: titleController.text.trim(),
                  content: contentController.text.trim(),
                  category: selectedCategory,
                  isCompleted:
                      widget.task.isCompleted,                );

                ref
                    .read(taskProvider.notifier)
                    .updateTask(
                      updatedTask.id,
                      updatedTask.title,
                      updatedTask.content,
                      updatedTask.category,
                    );

                Navigator.pop(context);
              },

              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}

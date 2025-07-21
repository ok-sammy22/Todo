import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/task_provider.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/screens/edit_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true),
      body:
          taskList.isEmpty
              ? const Center(
                child: Text(
                  'No tasks available',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  return Dismissible(
                    key: ValueKey(taskList[index].id), 
                    onDismissed: (direction) {
                      ref
                          .read(taskProvider.notifier)
                          .deleteTask(taskList[index].id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${task.title} deleted'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration:
                              task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),
                      subtitle: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${task.category.name.toUpperCase()} ',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: task.content,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),

                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          ref
                              .read(taskProvider.notifier)
                              .completedtask(task.id);
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditScreen(task: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddNewTask()));
          // final task = Task(
          //   id: uuid.v4(),
          //   title: 'Eat',
          //   content: 'Eat lunch',
          //   category: Category.personal,
          // );
          // ref.read(taskProvider.notifier).addTask(task);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

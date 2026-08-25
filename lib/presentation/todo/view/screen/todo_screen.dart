import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/todo/data/todo.model.dart';
import 'package:lukethompson/presentation/todo/data/todo.provider.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _createTodo() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;
    ref.read(createTodoProvider.notifier).call(title);
    _titleController.clear();
  }

  void _updateTodo(Todo todo) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorManager.boxColor,
        title: const Text('Edit Todo'),
        content: TextField(
          controller: TextEditingController(text: todo.title),
          decoration: const InputDecoration(labelText: 'Title'),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(updateTodoProvider.notifier).call(
                    todo.id,
                    {"title": todo.title},
                  );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteTodo(int id) {
    ref.read(deleteTodoProvider.notifier).call(id);
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(getTodosProvider);
    final createAsync = ref.watch(createTodoProvider);

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        title: const Text('Todo Demo'),
        backgroundColor: ColorManager.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter todo title',
                      hintStyle: const TextStyle(color: ColorManager.greyText),
                      filled: true,
                      fillColor: ColorManager.boxColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                createAsync.isLoading
                    ? const CircularProgressIndicator(color: ColorManager.primaryButton)
                    : GlobalButton(
                        label: 'Add',
                        onTap: createAsync.isLoading ? null : _createTodo,
                      ),
              ],
            ),
          ),
          Expanded(
            child: todosAsync.when(
              skipLoadingOnRefresh: true,
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text('Error: $e', style: const TextStyle(color: ColorManager.redColor)),
              ),
              data: (todos) => todos.isEmpty
                  ? const Center(child: Text('No todos', style: TextStyle(color: ColorManager.greyText)))
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      itemCount: todos.length,
                      itemBuilder: (_, i) => _TodoCard(
                        todo: todos[i],
                        onEdit: () => _updateTodo(todos[i]),
                        onDelete: () => _deleteTodo(todos[i].id),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TodoCard({
    required this.todo,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.boxColor,
      margin: EdgeInsets.only(bottom: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        title: Text(
          todo.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'User ${todo.userId}',
          style: const TextStyle(color: ColorManager.greyText),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: ColorManager.collectionRate),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: ColorManager.redColor),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class GlobalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const GlobalButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: onTap != null ? ColorManager.primaryButton : ColorManager.primaryButtonDark,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

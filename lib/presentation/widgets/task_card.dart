import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Task Description'),
            const Text('Task Date'),
            Row(
              children: [
                const Chip(
                  label: Text('New'),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
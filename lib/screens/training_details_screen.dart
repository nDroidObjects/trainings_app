import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> training;

  const TrainingDetailsScreen({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${training['name']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${training['title']}",
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Date: ${training['date']}'),
            const SizedBox(height: 8.0),
            Text('Time: ${training['time']}'),
            const SizedBox(height: 8.0),
            Text('Trainer/Speaker: ${training['trainer']}'),
            const SizedBox(height: 8.0),
            Text('Location: ${training['location']}'),
            const SizedBox(height: 16.0),
            const Text(
              'Summary:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'This training will cover Safe Scrum Master principles, '
              'frameworks, and practices, providing a comprehensive understanding of agile methodologies.',
            ),
          ],
        ),
      ),
    );
  }
}

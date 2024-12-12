import 'package:flutter/material.dart';

class ViewFeedbackFormByEventPage extends StatelessWidget {
  final Event event;
  final FeedbackForm feedbackForm;

  const ViewFeedbackFormByEventPage({
    super.key,
    required this.event,
    required this.feedbackForm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form for ${event.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Name: ${event.name}'),
            Text('Date: ${event.date.toLocal()}'),
            Text('Location: ${event.location}'),
            const Divider(height: 32),
            Text(
              'Feedback Form Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Title: ${feedbackForm.title}'),
            Text('RSVP Required: ${feedbackForm.isRSVP ? "Yes" : "No"}'),
            const SizedBox(height: 16),
            Text(
              'Questions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: feedbackForm.questions.length,
                itemBuilder: (context, index) {
                  final question = feedbackForm.questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Q${index + 1}: ${question.text}'),
                      subtitle: Text('Type: ${question.type.name}'),
                      trailing: question.options != null && question.options!.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.list),
                              onPressed: () {
                                _showOptionsDialog(context, question.options!);
                              },
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) => Text(option)).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Supporting Classes

class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
  });
}

enum QuestionType { multipleChoice, ratingScale, openEnded }

extension QuestionTypeExtension on QuestionType {
  String get name {
    switch (this) {
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
      case QuestionType.ratingScale:
        return 'Rating Scale';
      case QuestionType.openEnded:
        return 'Open Ended';
    }
  }
}

class FeedbackForm {
  final String id;
  final String title;
  final bool isRSVP;
  final List<Question> questions;

  FeedbackForm({
    required this.id,
    required this.title,
    required this.isRSVP,
    required this.questions,
  });
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<String>? options;

  Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
  });
}


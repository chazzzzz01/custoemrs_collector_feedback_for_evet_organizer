import 'package:flutter/material.dart';

class ViewAllFeedbackFormsPage extends StatelessWidget {
  final List<FeedbackForm> feedbackForms;

  const ViewAllFeedbackFormsPage({super.key, required this.feedbackForms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View All Feedback Forms'),
      ),
      body: feedbackForms.isEmpty
          ? const Center(
              child: Text('No feedback forms to display.'),
            )
          : ListView.builder(
              itemCount: feedbackForms.length,
              itemBuilder: (context, index) {
                final form = feedbackForms[index];
                return ExpansionTile(
                  title: Text(form.title),
                  subtitle: Text('RSVP: ${form.isRSVP ? 'Required' : 'Not Required'}'),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: form.questions.length,
                      itemBuilder: (context, questionIndex) {
                        final question = form.questions[questionIndex];
                        return ListTile(
                          title: Text('Q${questionIndex + 1}: ${question.text}'),
                          subtitle: Text('Type: ${question.type.name}'),
                          isThreeLine: true,
                          trailing: question.options != null && question.options!.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.list),
                                  onPressed: () {
                                    _showOptionsDialog(context, question.options!);
                                  },
                                )
                              : null,
                        );
                      },
                    ),
                  ],
                );
              },
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

// Enums and classes required for the page

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

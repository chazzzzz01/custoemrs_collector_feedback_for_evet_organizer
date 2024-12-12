import 'package:customers_collector_feedback/features/feedback_management/data/models/feedback_model.dart';
import 'package:flutter/material.dart';

class ViewFeedbackFormPage extends StatelessWidget {
  final FeedbackFormModel feedbackForm;

  const ViewFeedbackFormPage({super.key, required this.feedbackForm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form: ${feedbackForm.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Form Title:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              feedbackForm.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 16),

            // RSVP Status
            Text(
              'RSVP Status:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              feedbackForm.isRSVP ? 'Required' : 'Optional',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 16),

            // Questions
            Text(
              'Questions:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            feedbackForm.questions.isEmpty
                ? const Text('No questions available.')
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: feedbackForm.questions.length,
                    itemBuilder: (context, index) {
                      final question = feedbackForm.questions[index];
                      return ListTile(
                        title: Text(
                          '${index + 1}. ${question.text}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          'Type: ${question.type.toString().split('.').last}',
                        ),
                        trailing: question.options != null &&
                                question.options!.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.list),
                                onPressed: () {
                                  _showOptionsDialog(context, question.options!);
                                },
                              )
                            : null,
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                  ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, List<String> options) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Options'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

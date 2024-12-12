import 'package:flutter/material.dart';

class FeedbackFormListPage extends StatefulWidget {
  const FeedbackFormListPage({super.key});

  @override
  State<FeedbackFormListPage> createState() => _FeedbackFormListPageState();
}

class _FeedbackFormListPageState extends State<FeedbackFormListPage> {
  final List<FeedbackForm> _feedbackForms = [];

  void _addOrEditFeedbackForm(FeedbackForm? form) async {
    final result = await Navigator.push<FeedbackForm>(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackFormPage(existingForm: form),
      ),
    );

    if (result != null) {
      setState(() {
        if (form != null) {
          // Edit existing form
          final index = _feedbackForms.indexWhere((f) => f.id == form.id);
          if (index != -1) _feedbackForms[index] = result;
        } else {
          // Add new form
          _feedbackForms.add(result);
        }
      });
    }
  }

  void _deleteFeedbackForm(String id) {
    setState(() {
      _feedbackForms.removeWhere((form) => form.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Forms'),
      ),
      body: _feedbackForms.isEmpty
          ? const Center(
              child: Text('No feedback forms available.'),
            )
          : ListView.builder(
              itemCount: _feedbackForms.length,
              itemBuilder: (context, index) {
                final form = _feedbackForms[index];
                return Card(
                  child: ListTile(
                    title: Text(form.title),
                    subtitle: Text('Questions: ${form.questions.length}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _addOrEditFeedbackForm(form),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteFeedbackForm(form.id);
                          },
                        ),
                      ],
                    ),
                    onTap: () => _addOrEditFeedbackForm(form),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditFeedbackForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Enums and classes required for the page

enum QuestionType { multipleChoice, ratingScale, openEnded }

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

// FeedbackFormPage Placeholder (replace with your implementation)
class FeedbackFormPage extends StatelessWidget {
  final FeedbackForm? existingForm;

  const FeedbackFormPage({super.key, this.existingForm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(existingForm == null ? 'Add Feedback Form' : 'Edit Feedback Form'),
      ),
      body: const Center(
        child: Text('Feedback Form Page Placeholder'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FeedbackFormPage extends StatefulWidget {
  final FeedbackForm? existingForm;

  const FeedbackFormPage({super.key, this.existingForm});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late bool _isRSVP;
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingForm != null) {
      _title = widget.existingForm!.title;
      _isRSVP = widget.existingForm!.isRSVP;
      _questions = List.from(widget.existingForm!.questions);
    } else {
      _title = '';
      _isRSVP = false;
    }
  }

  void _addQuestion() {
    setState(() {
      _questions.add(
        Question(
          id: UniqueKey().toString(),
          text: '',
          type: QuestionType.openEnded,
        ),
      );
    });
  }

  void _removeQuestion(Question question) {
    setState(() {
      _questions.remove(question);
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newForm = FeedbackForm(
        id: widget.existingForm?.id ?? UniqueKey().toString(),
        title: _title,
        isRSVP: _isRSVP,
        questions: _questions,
      );
      Navigator.pop(context, newForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingForm == null ? 'Add Feedback Form' : 'Edit Feedback Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _title,
                  decoration: const InputDecoration(labelText: 'Form Title'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!.trim(),
                ),
                SwitchListTile(
                  title: const Text('RSVP Required'),
                  value: _isRSVP,
                  onChanged: (value) {
                    setState(() {
                      _isRSVP = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    final question = _questions[index];
                    return Card(
                      child: ListTile(
                        title: TextFormField(
                          initialValue: question.text,
                          decoration: const InputDecoration(labelText: 'Question Text'),
                          onChanged: (value) {
                            setState(() {
                              _questions[index] = Question(
                                id: question.id,
                                text: value,
                                type: question.type,
                                options: question.options,
                              );
                            });
                          },
                        ),
                        subtitle: DropdownButton<QuestionType>(
                          value: question.type,
                          onChanged: (value) {
                            setState(() {
                              _questions[index] = Question(
                                id: question.id,
                                text: question.text,
                                type: value!,
                                options: value == QuestionType.multipleChoice ? [] : null,
                              );
                            });
                          },
                          items: QuestionType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            );
                          }).toList(),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeQuestion(question),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addQuestion,
                  child: const Text('Add Question'),
                ),
              ],
            ),
          ),
        ),
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

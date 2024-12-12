import 'package:equatable/equatable.dart';

class FeedbackForm extends Equatable {
  final String id;
  final String title;
  final List<Question> questions;

  const FeedbackForm({
    required this.id,
    required this.title,
    required this.questions, required bool isRSVP,
  });

  @override
  List<Object?> get props => [id, title, questions];

  get isRSVP => null;
}

class Question extends Equatable {
  final String id;
  final String text;
  final QuestionType type;
  final List<String>? options; // Nullable for non-multiple-choice questions

  const Question({
    required this.id,
    required this.text,
    required this.type,
    this.options,
  });

  @override
  List<Object?> get props => [id, text, type, options];
}

enum QuestionType { multipleChoice, ratingScale, openEnded }

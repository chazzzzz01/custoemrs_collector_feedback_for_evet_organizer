import 'dart:convert';
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';


class FeedbackFormModel extends FeedbackForm {
  const FeedbackFormModel({
    required super.id,
    required super.title,
    required List<QuestionModel> super.questions, required super.isRSVP,
  });

  /// Convert Map to FeedbackFormModel
  factory FeedbackFormModel.fromMap(Map<String, dynamic> map) {
    return FeedbackFormModel(
      id: map['id'] as String,
      title: map['title'] as String,
      questions: (map['questions'] as List)
          .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList(), isRSVP: true,
    );
  }

  /// Convert JSON String to FeedbackFormModel
  factory FeedbackFormModel.fromJson(String source) {
    return FeedbackFormModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  /// Convert FeedbackFormModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'questions': questions.map((q) => (q as QuestionModel).toMap()).toList(),
    };
  }

  /// Convert FeedbackFormModel to JSON String
  String toJson() {
    return json.encode(toMap());
  }
}

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.text,
    required super.type,
    super.options,
  });

  /// Convert Map to QuestionModel
  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as String,
      text: map['text'] as String,
      type: QuestionType.values[map['type'] as int],
      options: map['options'] != null ? List<String>.from(map['options']) : null,
    );
  }

  /// Convert JSON String to QuestionModel
  factory QuestionModel.fromJson(String source) {
    return QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  /// Convert QuestionModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'type': type.index, // Save enum as its index
      'options': options,
    };
  }

  /// Convert QuestionModel to JSON String
  String toJson() {
    return json.encode(toMap());
  }
}

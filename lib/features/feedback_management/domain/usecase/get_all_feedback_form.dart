import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/repositories/feedback_repo.dart';
import 'package:dartz/dartz.dart';
class GetAllFeedbackForms {
  final FeedbackFormRepository repository;

  GetAllFeedbackForms({required this.repository});

  Future<Either<Failure, List<FeedbackForm>>> call() async {
    return await repository.getAllFeedbackForms();
  }
}

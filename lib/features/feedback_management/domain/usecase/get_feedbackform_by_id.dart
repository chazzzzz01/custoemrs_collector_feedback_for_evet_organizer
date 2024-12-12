import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/repositories/feedback_repo.dart';
import 'package:dartz/dartz.dart';

class GetFeedbackFormById {
  final FeedbackFormRepository repository;

  GetFeedbackFormById({required this.repository});

  Future<Either<Failure, FeedbackForm?>> call(String id) async {
    return await repository.getFeedbackFormById(id);
  }
}

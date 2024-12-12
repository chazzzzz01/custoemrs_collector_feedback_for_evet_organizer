
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class FeedbackFormRepository {
  Future<Either<Failure, void>> createFeedbackForm(FeedbackForm form);
  Future<Either<Failure, FeedbackForm?>> getFeedbackFormById(String id);
  Future<Either<Failure, List<FeedbackForm>>> getAllFeedbackForms();
  Future<Either<Failure, void>> updateFeedbackForm(FeedbackForm form);
  Future<Either<Failure, void>> deleteFeedbackForm(String id);
}

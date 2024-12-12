import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/repositories/feedback_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

class CreateFeedbackForm {
  final FeedbackFormRepository repository;

  CreateFeedbackForm({required this.repository});

  Future<Either<Failure, void>> call(FeedbackForm form) async {
    return await repository.createFeedbackForm(form);
  }
}

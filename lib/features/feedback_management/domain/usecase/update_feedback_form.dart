import 'package:customers_collector_feedback/features/feedback_management/domain/repositories/feedback_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/feedback.dart';

class UpdateFeedbackForm {
  final FeedbackFormRepository repository;

  UpdateFeedbackForm({required this.repository});

  Future<Either<Failure, void>> call(FeedbackForm form) async {
    return await repository.updateFeedbackForm(form);
  }
}

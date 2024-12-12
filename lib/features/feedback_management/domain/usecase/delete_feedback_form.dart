import 'package:customers_collector_feedback/features/feedback_management/domain/repositories/feedback_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

class DeleteFeedbackForm {
  final FeedbackFormRepository repository;

  DeleteFeedbackForm({required this.repository});

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteFeedbackForm(id);
  }
}


import '../../domain/entities/feedback.dart';

abstract class FeedbackFormRemoteDataSource {
  Future<void> createFeedbackForm(FeedbackForm form);
  Future<FeedbackForm?> getFeedbackFormById(String id);
  Future<List<FeedbackForm>> getAllFeedbackForms();
  Future<void> updateFeedbackForm(FeedbackForm form);
  Future<void> deleteFeedbackForm(String id);
}
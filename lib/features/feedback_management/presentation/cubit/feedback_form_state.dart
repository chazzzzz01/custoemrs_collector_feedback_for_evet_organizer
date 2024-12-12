// Define different states for FeedbackFormCubit
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackFormState extends Equatable {
  const FeedbackFormState();

  @override
  List<Object?> get props => [];
}

// Initial State
class FeedbackFormInitial extends FeedbackFormState {}

// Loading State
class FeedbackFormLoading extends FeedbackFormState {}

class FeedbackFormAdded extends FeedbackFormState {}

class FeedbackFormDeleted extends FeedbackFormState {}

class FeedbackFormUpdated extends FeedbackFormState {
  final FeedbackForm newFeedbackForm;

  const FeedbackFormUpdated(this.newFeedbackForm);

  @override
  List<Object?> get props => [newFeedbackForm];  
}


// Success State (with List<FeedbackForm>)
class FeedbackFormLoaded extends FeedbackFormState {
  final List<FeedbackForm> feedbackForms;

  const FeedbackFormLoaded({required this.feedbackForms});

  @override
  List<Object?> get props => [feedbackForms];
}

// Error State (with error message)
class FeedbackFormError extends FeedbackFormState {
  final String message;

  const FeedbackFormError(this.message);

  @override
  List<Object?> get props => [message];
}
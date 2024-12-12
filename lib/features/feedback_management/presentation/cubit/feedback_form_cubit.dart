// ignore_for_file: recursive_getters

import 'dart:async';

import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/usecase/create_feedback_form.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/usecase/delete_feedback_form.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/usecase/get_all_feedback_form.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/usecase/get_feedbackform_by_id.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/usecase/update_feedback_form.dart';
import 'package:customers_collector_feedback/features/feedback_management/presentation/cubit/feedback_form_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';


const String noInternetErrorMessage =
    "Sync Failed: Changes saved on your device and will sync once you're back online.";

class FeedbackFormCubit extends Cubit<FeedbackFormState> {
  final CreateFeedbackForm createFeedbackFormUseCase;
  final DeleteFeedbackForm deleteFeedbackFormUseCase;
  final GetFeedbackFormById getFeedbackFormByIdUseCase;
  final UpdateFeedbackForm updateFeedbackFormUseCase;
  final GetAllFeedbackForms getAllFeedbackFormsUseCase;

  // Local cache for the feedbackForm list
  List<FeedbackForm> _feedbackFormsCache = [];

  FeedbackFormCubit({
    required this.createFeedbackFormUseCase,
    required this.deleteFeedbackFormUseCase,
    required this.getFeedbackFormByIdUseCase,
    required this.updateFeedbackFormUseCase,
    required this.getAllFeedbackFormsUseCase,
  }) : super(FeedbackFormInitial());
  
  List<FeedbackForm> get feedbackForms => feedbackForms;

  // Get feedbackForm by id and cache them locally
  Future<void> getFeedbackFormById(String eventId) async {
    emit(FeedbackFormLoading());

    try {
      final Either<Failure, FeedbackForm?> result =
          await getFeedbackFormByIdUseCase.call(eventId).timeout(
                const Duration(seconds: 10),
                onTimeout: () => throw TimeoutException("Request timed out"),
              );

      result.fold(
        (failure) => emit(FeedbackFormError(failure.getMessage())),
        (FeedbackForms) {
          _feedbackFormsCache = feedbackForms;
          emit(FeedbackFormLoaded(feedbackForms: _feedbackFormsCache));
        },
      );
    } on TimeoutException catch (_) {
      emit(const FeedbackFormError("There seems to be a problem with your Internet connection"));
    }
  }

  // Create feedbackForm and add to cache
  Future<void> createFeedbackForm(FeedbackForm feedbackForm) async {
    emit(FeedbackFormLoading());

    try {
      final Either<Failure, void> result =
          await createFeedbackFormUseCase.call(feedbackForm);

      result.fold(
        (failure) => emit(FeedbackFormError(failure.getMessage())),
        (_) {
          emit(FeedbackFormAdded());
        },
      );
    } catch (_) {
      emit(const FeedbackFormError(noInternetErrorMessage));
    }
  }

  // Update a feedbackForm and modify it in the cache
  Future<void> updateFeedbackForm(FeedbackForm feedbackForm) async {
    emit(FeedbackFormLoading());

    try {
      final Either<Failure, void> result = await updateFeedbackFormUseCase
          .call(feedbackForm)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out."));

      result.fold(
        (failure) => emit(FeedbackFormError(failure.getMessage())),
        (_) {
          emit(FeedbackFormUpdated(feedbackForm));
        },
      );
    } catch (_) {
      emit(const FeedbackFormError(noInternetErrorMessage));
    }
  }

  // Delete a feedbackForms from the cache
  Future<void> deleteFeedbackForm(String id) async {
    emit(FeedbackFormLoading());

    try {
      final Either<Failure, void> result = await deleteFeedbackFormUseCase
          .call(id)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(FeedbackFormError(failure.getMessage())),
        (_) {
          _feedbackFormsCache.removeWhere((feedbackForm) => feedbackForm.id == id);
          emit(FeedbackFormLoaded(feedbackForms: _feedbackFormsCache));
        },
      );
    } catch (_) {
      emit(const FeedbackFormError(noInternetErrorMessage));
    }
  }

  // Get all feedbackForms and cache them locally
  Future<void> getAllfeedbackForms() async {
    emit(FeedbackFormLoading());

    final Either<Failure, List<FeedbackForm>> result =
        await getAllFeedbackFormsUseCase.call();

    result.fold(
      (failure) => emit(FeedbackFormError(failure.getMessage())),
      (feedbackForms) {
        _feedbackFormsCache = feedbackForms;
        emit(FeedbackFormLoaded(feedbackForms: _feedbackFormsCache));
      },
    );
  }
}
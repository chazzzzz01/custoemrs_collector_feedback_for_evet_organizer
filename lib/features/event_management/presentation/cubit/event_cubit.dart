import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:customers_collector_feedback/features/event_management/domain/usecase/get_event.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/event.dart';
import '../../domain/usecase/creete_event.dart';
import '../../domain/usecase/delete_event.dart';
import '../../domain/usecase/get_all_events.dart';
import '../../domain/usecase/update.dart';
import 'event_state.dart';

const String noInternetErrorMessage =
    "Sync Failed: Changes saved on your device and will sync once you're back online.";


class EventCubit extends Cubit<EventState> {
  final CreateEvent createEventUseCase;
  final DeleteEvent deleteEventUseCase;
  final GetEvent getEventByIdUseCase;
  final GetAllEvents getAllEventsUseCase;
  final UpdateEvent updateEventUseCase;

  EventCubit({
    required this.createEventUseCase,
    required this.deleteEventUseCase,
    required this.getEventByIdUseCase,
    required this.getAllEventsUseCase,
    required this.updateEventUseCase,
  }) : super(EventInitial());

  // Get events and cache them locally
  Future<void> getAllEvents() async {
    emit(EventLoading());

    try {
      final Either<Failure, List<Event>> result = await getAllEventsUseCase
          .call()
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(EventError(failure.getMessage())),
        (events) {
          emit(EventLoaded(events: events));
        },
      );
    } on TimeoutException catch (_) {
      emit(const EventError(
          "There seems to be a problem with your Internet connection"));
    }
  }

  // Create event and add to cache
  Future<void> createEvent(Event event) async {
    // ignore: avoid_print
    print("Guest IDs before saving: ${event.id}"); // Debug log
    emit(EventLoading());

    try {
      final Either<Failure, void> result = await createEventUseCase
          .call(event)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(EventError(failure.getMessage())),
        (_) {
          emit(EventAdded());
        },
      );
    } catch (_) {
      emit(const EventError(noInternetErrorMessage));
    }
  }

  // Update an event and modify it in the cache
  Future<void> updateEvent(Event event) async {
    emit(EventLoading());

    try {
      final Either<Failure, void> result = await updateEventUseCase
          .call(event)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(EventError(failure.getMessage())),
        (_) {
          emit(EventUpdated(event));
        },
      );
    } catch (_) {
      emit(const EventError(noInternetErrorMessage));
    }
  }

  // Delete an event from the cache
  Future<void> deleteEvent(Event event) async {
    emit(EventLoading());

    try {
      final Either<Failure, void> result = await deleteEventUseCase(event).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );

      result.fold(
        (failure) => emit(EventError(failure.getMessage())),
        (_) {
          emit(EventDeleted());
        },
      );
    } catch (_) {
      emit(const EventError(noInternetErrorMessage));
    }
  }

  

  // // Helper method to map Failure to readable message
  // String _mapFailureToMessage(Failure failure) {
  //   // Customize this according to your error handling strategy
  //   return failure.toString();
  // }
}

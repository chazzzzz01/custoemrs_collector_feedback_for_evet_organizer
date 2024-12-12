import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/event.dart';
abstract class EventRepository {
  Future<Either<Failure, void>> createEvent(Event event);
  Future<Either<Failure, Event?>> getEvent(String id);
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, void>> updateEvent(Event event);
  Future<Either<Failure, void>> deleteEvent(String id);
}

import 'package:customers_collector_feedback/core/errors/exceptions.dart';
import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:customers_collector_feedback/features/event_management/data/data_source/event_remote_datasource.dart';
import 'package:customers_collector_feedback/features/event_management/domain/entities/event.dart';
import 'package:customers_collector_feedback/features/event_management/domain/repositories/event_repository.dart';
import 'package:dartz/dartz.dart';

class EventRepositoryImplementation implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  const EventRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> createEvent(Event event) async {
    try {
      return Right(await remoteDataSource.createEvent(event));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

   @override
  Future<Either<Failure, void>> deleteEvent(String id) async {
    try {
      return Right(await remoteDataSource.deleteEvent(id));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  } 
  
  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    try {
      return Right(await remoteDataSource.getAllEvents());
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

 @override
  Future<Either<Failure, Event?>> getEvent(String id) async {
    try {
      return Right(await remoteDataSource.getEvent(id));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }
   @override
  Future<Either<Failure, void>>updateEvent(Event event) async {
    try {
      return Right(await remoteDataSource.updateEvent(event));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }
}

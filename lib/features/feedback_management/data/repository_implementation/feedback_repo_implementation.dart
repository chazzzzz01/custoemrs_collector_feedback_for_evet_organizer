import 'package:customers_collector_feedback/core/errors/exceptions.dart';
import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:customers_collector_feedback/features/feedback_management/data/data_source/feedback_remote_datasource.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/repositories/feedback_repo.dart';
import 'package:dartz/dartz.dart';
class FeedbackRepositoryImplementation implements FeedbackFormRepository {
  final FeedbackFormRemoteDataSource remoteDataSource;

  const FeedbackRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> createFeedbackForm(FeedbackForm form) async {
    try {
      return Right(await remoteDataSource.createFeedbackForm(form));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

   @override
  Future<Either<Failure, void>> deleteFeedbackForm(String id) async {
    try {
      return Right(await remoteDataSource.deleteFeedbackForm(id));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  } 
  
  @override
  Future<Either<Failure, List<FeedbackForm>>> getAllFeedbackForms() async {
    try {
      return Right(await remoteDataSource.getAllFeedbackForms());
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

 @override
  Future<Either<Failure, FeedbackForm?>> getFeedbackFormById(String id) async {
    try {
      return Right(await remoteDataSource.getFeedbackFormById(id));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }
   @override
  Future<Either<Failure, void>>updateFeedbackForm(FeedbackForm form) async {
    try {
      return Right(await remoteDataSource.updateFeedbackForm(form));
    } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch(e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }
}

import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:customers_collector_feedback/features/feedback_management/data/repository_implementation/feedback_repo_implementation.dart';
import 'package:customers_collector_feedback/features/feedback_management/domain/entities/feedback.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'feedback_remote_datasource.mock.dart';


void main() {
  late FeedbackRepositoryImplementation feedbackFormRepositoryUnderTest;
  late MockFeedbackFormRemoteDataSource mockFeedbackFormRemoteDataSource;

  setUp(() {
    mockFeedbackFormRemoteDataSource = MockFeedbackFormRemoteDataSource();
    feedbackFormRepositoryUnderTest =
        FeedbackRepositoryImplementation(mockFeedbackFormRemoteDataSource);
  });

  const feedbackForm = FeedbackForm(
    id: 'form1',
    title: 'Event Feedback',
    questions: [
      Question(
        id: 'q1',
        text: 'How was the event?',
        type: QuestionType.openEnded,
      ),
    ], isRSVP: true,
  );


 group('createFeeddbackForm', () {
    test('should return void on success', () async {
      // Arrange: Stub the createGuest method to return a successful response (void)
      when(() => mockFeedbackFormRemoteDataSource.createFeedbackForm(feedbackForm))
          .thenAnswer((_) async => Future.value());

      // Act: Call the repository's createGuest method
      final result = await feedbackFormRepositoryUnderTest.createFeedbackForm(feedbackForm);

      // Assert: Verify the method was called and the result is a Right (success)
      verify(() => mockFeedbackFormRemoteDataSource.createFeedbackForm(feedbackForm)).called(1);
      expect(result, equals(const Right(null)));
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });

    test(
        'should return Failure when the remote data source throws an exception',
        () async {
      // Arrange: Stub the createGuest method to throw an exception
      when(() => mockFeedbackFormRemoteDataSource.createFeedbackForm(feedbackForm))
          .thenThrow(Exception());

      // Act: Call the repository's createGuest method
      final result = await feedbackFormRepositoryUnderTest.createFeedbackForm(feedbackForm);

      // Assert: Verify the method was called and the result is a Left (Failure)
      expect(result, isA<Left<Failure, void>>()); // Expecting a failure
      verify(() => mockFeedbackFormRemoteDataSource.createFeedbackForm(feedbackForm)).called(1);
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });
  });

  group('deleteFeedbackForm', () {
    test('should return void on success', () async {
      // Arrange: Stub the deleteGuest method to return a successful response (void)
      when(() => mockFeedbackFormRemoteDataSource.deleteFeedbackForm('1'))
          .thenAnswer((_) async => Future.value());

      // Act: Call the repository's deleteGuest method
      final result = await feedbackFormRepositoryUnderTest.deleteFeedbackForm('1');

      // Assert: Verify the method was called and the result is a Right (success)
      verify(() => mockFeedbackFormRemoteDataSource.deleteFeedbackForm('1')).called(1);
      expect(result, equals(const Right(null)));
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });

    test(
        'should return Failure when the remote data source throws an exception',
        () async {
      // Arrange: Stub the deleteGuest method to throw an exception
      when(() => mockFeedbackFormRemoteDataSource.deleteFeedbackForm('1'))
          .thenThrow(Exception('Failed to delete FeedbackForm'));

      // Act: Call the repository's deleteGuest method
      final result = await feedbackFormRepositoryUnderTest.deleteFeedbackForm('1');

      // Assert: Verify the method was called and the result is a Left (Failure)
      expect(result, isA<Left<Failure, void>>()); // Expecting a failure
      verify(() => mockFeedbackFormRemoteDataSource.deleteFeedbackForm('1')).called(1);
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });
  });

  group('getAllFeedbackForms', () {
    test('should return FeedbackForm when successful', () async {
      // Arrange
      when(() => mockFeedbackFormRemoteDataSource.getAllFeedbackForms())
          // ignore: null_argument_to_non_null_type
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await feedbackFormRepositoryUnderTest.getAllFeedbackForms();

      // Assert
      verify(() => mockFeedbackFormRemoteDataSource.getAllFeedbackForms()).called(1);
      expect(result, const Right(feedbackForm));
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });

    test(
        'should return Failure when the remote data source throws an exception',
        () async {
      // Arrange
      when(() => mockFeedbackFormRemoteDataSource.getAllFeedbackForms())
          .thenThrow(Exception('Failed to get FeedbackForm'));

      // Act
      final result = await feedbackFormRepositoryUnderTest.getAllFeedbackForms();

      // Assert
      expect(result, isA<Left<Failure, FeedbackForm?>>());
      verify(() => mockFeedbackFormRemoteDataSource.getAllFeedbackForms()).called(1);
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });
  });

 group('getFeedbackFormById', () {
    test('should return FeedbackForm when successful', () async {
      // Arrange
      when(() => mockFeedbackFormRemoteDataSource.getFeedbackFormById('1'))
          .thenAnswer((_) async => feedbackForm);

      // Act
      final result = await feedbackFormRepositoryUnderTest.getFeedbackFormById('1');

      // Assert
      expect(result, Right(feedbackFormRepositoryUnderTest));
      verify(() => mockFeedbackFormRemoteDataSource.getFeedbackFormById('1')).called(1);
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });

    test('should return Failure when fetching FeedbackForm fails', () async {
      // Arrange
      when(() => mockFeedbackFormRemoteDataSource.getFeedbackFormById('1'))
          .thenThrow(Exception());

      // Act
      final result = await feedbackFormRepositoryUnderTest.getFeedbackFormById('1');

      // Assert
      expect(result, isA<Left<Failure, FeedbackForm?>>());
      verify(() => mockFeedbackFormRemoteDataSource.getFeedbackFormById('1')).called(1);
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });
  });


  group('updateFeedbackForm', () {
    test('should return Void if the FeedbackForm was updated successfully', () async {
      // Arrange: Stub the updateGuest method to return a successful response (void)
      when(() => mockFeedbackFormRemoteDataSource.updateFeedbackForm(feedbackForm))
          .thenAnswer((_) async => Future.value());
        
      // Act: Call the repository's updateGuest method
      final result = await feedbackFormRepositoryUnderTest.updateFeedbackForm(feedbackForm);

      // Assert: Verify the method was called and the result is a Right (success)
      verify(() => mockFeedbackFormRemoteDataSource.updateFeedbackForm(feedbackForm)).called(1);
      expect(result, equals(const Right(null)));
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });

    test(
        'should return Failure when the remote data source throws an exception',
        () async {
      // Arrange: Stub the updateGuest method to throw an exception
      when(() => mockFeedbackFormRemoteDataSource.updateFeedbackForm(feedbackForm))
          .thenThrow(Exception('Failed to update guest'));

      // Act: Call the repository's updateGuest method
      final result = await feedbackFormRepositoryUnderTest.updateFeedbackForm(feedbackForm);

      // Assert: Verify the method was called and the result is a Left (Failure)
      expect(result, isA<Left<Failure, void>>()); // Expecting a failure
      verify(() => mockFeedbackFormRemoteDataSource.updateFeedbackForm(feedbackForm)).called(1);
      verifyNoMoreInteractions(mockFeedbackFormRemoteDataSource);
    });
  });
}
 
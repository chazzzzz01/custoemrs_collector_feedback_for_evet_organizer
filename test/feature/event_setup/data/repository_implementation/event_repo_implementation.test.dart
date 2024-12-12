import 'package:customers_collector_feedback/core/errors/exceptions.dart';
import 'package:customers_collector_feedback/core/errors/failure.dart';
import 'package:customers_collector_feedback/features/event_management/data/repository_implementation/event_repo_implementation.dart';
import 'package:customers_collector_feedback/features/event_management/domain/entities/event.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'event_remote_datasource.mock.dart';

void main() {
  late EventRepositoryImplementation eventRepositoryUnderTest;
  late MockEventRemoteDataSource mockEventRemoteDataSource;

  setUp(() {
    mockEventRemoteDataSource = MockEventRemoteDataSource();
    eventRepositoryUnderTest =
        EventRepositoryImplementation(mockEventRemoteDataSource);
  });


  final testEvent = Event(
    id: '1',
    title: 'Test Event',
    date: DateTime(2024, 1, 1),
    location: 'Test Location', description: 'office event', time: '10pm', guestIds: const [],
  );

   final testEventList = [testEvent];

  group('createEvent', () {
    test('should return void when the event is created successfully', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.createEvent(testEvent))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await eventRepositoryUnderTest.createEvent(testEvent);

      // Assert
      expect(result, equals(const Right(null))); // Checking for success (void)
      verify(() => mockEventRemoteDataSource.createEvent(testEvent)).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });

    test('should return Failure when the event creation fails', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.createEvent(testEvent))
          .thenThrow(Exception());

      // Act
      final result = await eventRepositoryUnderTest.createEvent(testEvent);

      // Assert
      expect(result, isA<Left<Failure, void>>()); // Expecting a failure
      verify(() => mockEventRemoteDataSource.createEvent(testEvent)).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });
  });

  group('getEventById', () {
    test('should return event when successful', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.getEvent('1'))
          .thenAnswer((_) async => testEvent);

      // Act
      final result = await eventRepositoryUnderTest.getEvent('1');

      // Assert
      expect(result, Right(testEvent));
      verify(() => mockEventRemoteDataSource.getEvent('1')).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });

    test('should return Failure when fetching event fails', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.getEvent('1'))
          .thenThrow(Exception());

      // Act
      final result = await eventRepositoryUnderTest.getEvent('1');

      // Assert
      expect(result, isA<Left<Failure, Event?>>());
      verify(() => mockEventRemoteDataSource.getEvent('1')).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });
  });

  group('getAllEvents', () {
    test('should return List of events when successful', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.getAllEvents())
          .thenAnswer((_) async => testEventList);

      // Act
      final result = await eventRepositoryUnderTest.getAllEvents();

      // Assert
      expect(result, Right(testEventList));
      verify(() => mockEventRemoteDataSource.getAllEvents()).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });

    test('should return Failure when fetching events fails', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.getAllEvents()).thenThrow(
          const APIException(
              message: 'Something went wrong with the server',
              statusCode: "500"));

      // Act
      final result = await eventRepositoryUnderTest.getAllEvents();

      // Assert
      expect(result, isA<Left<Failure, List<Event>>>());
      verify(() => mockEventRemoteDataSource.getAllEvents()).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });
  });

  group('updateEvent', () {
    test('should return void when the event is updated successfully', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.updateEvent(testEvent))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await eventRepositoryUnderTest.updateEvent(testEvent);

      // Assert
      expect(result, equals(const Right(null))); // Checking for success (void)
      verify(() => mockEventRemoteDataSource.updateEvent(testEvent)).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });

    test('should return Failure when the event update fails', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.updateEvent(testEvent))
          .thenThrow(Exception());

      // Act
      final result = await eventRepositoryUnderTest.updateEvent(testEvent);

      // Assert
      expect(result, isA<Left<Failure, void>>()); // Expecting a failure
      verify(() => mockEventRemoteDataSource.updateEvent(testEvent)).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });
  });

  group('deleteEvent', () {
    test('should return void when the event is deleted successfully', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.deleteEvent('1'))
          .thenAnswer((_) async => Future.value());
        
      // Act
      final result = await eventRepositoryUnderTest.deleteEvent('1');

      // Assert
      expect(result, equals(const Right(null))); // Checking for success (void)
      verify(() => mockEventRemoteDataSource.deleteEvent('1')).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });

    test('should return Failure when the event deletion fails', () async {
      // Arrange
      when(() => mockEventRemoteDataSource.deleteEvent('1'))
          .thenThrow(Exception());

      // Act
      final result = await eventRepositoryUnderTest.deleteEvent('1');

      // Assert
      expect(result, isA<Left<Failure, void>>()); // Expecting a failure
      verify(() => mockEventRemoteDataSource.deleteEvent('1')).called(1);
      verifyNoMoreInteractions(mockEventRemoteDataSource);
    });
  });
}
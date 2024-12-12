import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customers_collector_feedback/features/event_management/domain/usecase/get_event.dart';
import 'package:customers_collector_feedback/features/feedback_management/presentation/cubit/feedback_form_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/event_management/data/data_source/event_remote_datasource.dart';
import '../../features/event_management/data/data_source/firebase_event_remote_datasource.dart';
import '../../features/event_management/data/repository_implementation/event_repo_implementation.dart';
import '../../features/event_management/domain/repositories/event_repository.dart';
import '../../features/event_management/domain/usecase/creete_event.dart';
import '../../features/event_management/domain/usecase/delete_event.dart';
import '../../features/event_management/domain/usecase/get_all_events.dart';
import '../../features/event_management/domain/usecase/update.dart';
import '../../features/event_management/presentation/cubit/event_cubit.dart';
import '../../features/feedback_management/data/data_source/feedback_remote_datasource.dart';
import '../../features/feedback_management/data/data_source/firebase_feedback_remote_datasource.dart';
import '../../features/feedback_management/data/repository_implementation/feedback_repo_implementation.dart';
import '../../features/feedback_management/domain/repositories/feedback_repo.dart';
import '../../features/feedback_management/domain/usecase/create_feedback_form.dart';
import '../../features/feedback_management/domain/usecase/delete_feedback_form.dart';
import '../../features/feedback_management/domain/usecase/get_all_feedback_form.dart';
import '../../features/feedback_management/domain/usecase/get_feedbackform_by_id.dart';
import '../../features/feedback_management/domain/usecase/update_feedback_form.dart';

final serviceLocator = GetIt.instance;
Future<void> init() async {
  // FEATURE 1: EVENT
  // Presentation Layer
  serviceLocator.registerFactory(() => EventCubit(
      createEventUseCase: serviceLocator(),
      deleteEventUseCase: serviceLocator(),
      getEventByIdUseCase: serviceLocator(),
      getAllEventsUseCase: serviceLocator(),
      updateEventUseCase: serviceLocator()));

  // Domain Layer
  serviceLocator.registerLazySingleton(() => CreateEvent(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteEvent(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetEvent(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateEvent(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllEvents(repository: serviceLocator()));

  // Data Layer
  serviceLocator.registerLazySingleton<EventRepository>(() => EventRepositoryImplementation(serviceLocator()));

  // Data Source
  serviceLocator.registerLazySingleton<EventRemoteDataSource>(() => EventFirebaseRemoteDatasource(serviceLocator()));
  
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

 // FEATURE 2: GUEST
  serviceLocator.registerFactory(() => FeedbackFormCubit(
      createFeedbackFormUseCase: serviceLocator(),
      deleteFeedbackFormUseCase: serviceLocator(),
      getFeedbackFormByIdUseCase: serviceLocator(),
      updateFeedbackFormUseCase: serviceLocator(),
      getAllFeedbackFormsUseCase: serviceLocator()));

  // Domain Layer
  serviceLocator.registerLazySingleton(() => CreateFeedbackForm(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteFeedbackForm(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateFeedbackForm(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetFeedbackFormById(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllFeedbackForms(repository: serviceLocator()));

  // Data Layer
  serviceLocator.registerLazySingleton<FeedbackFormRepository>(() => FeedbackRepositoryImplementation(serviceLocator()));

  // Data Source
  serviceLocator.registerLazySingleton<FeedbackFormRemoteDataSource>(() => FeedbackFormFirebaseRemoteDataSource(serviceLocator()));
}
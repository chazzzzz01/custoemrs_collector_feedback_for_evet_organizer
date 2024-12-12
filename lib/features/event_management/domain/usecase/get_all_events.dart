import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/event_repository.dart';
import '../entities/event.dart';

class GetAllEvents {
  final EventRepository repository;

  GetAllEvents({required this.repository});

  Future<Either<Failure, List<Event>>> call() async {
    return await repository.getAllEvents();
  }
}

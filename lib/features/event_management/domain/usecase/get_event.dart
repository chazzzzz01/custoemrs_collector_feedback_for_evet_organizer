import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/event_repository.dart';
import '../entities/event.dart';

class GetEvent {
  final EventRepository repository;

  GetEvent({required this.repository});

  Future<Either<Failure, Event?>> call(String id) async {
    return await repository.getEvent(id);
  }
}

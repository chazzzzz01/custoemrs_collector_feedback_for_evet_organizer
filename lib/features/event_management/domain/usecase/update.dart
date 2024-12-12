
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/event_repository.dart';
import '../entities/event.dart';

class UpdateEvent {
  final EventRepository repository;

  UpdateEvent({required this.repository});

  Future<Either<Failure, void>> call(Event event) async {
    return await repository.updateEvent(event);
  }
}

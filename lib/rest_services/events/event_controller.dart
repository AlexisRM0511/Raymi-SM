import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_repository.dart';

class EventController {
  final EventRepository _eventRepository;

  EventController(this._eventRepository);

  Future<void> createEvent(EventModel event) async =>
      _eventRepository.createEvent(event);

  Future<EventModel?> readEvent(String id) async =>
      _eventRepository.readEvent(id);

  Future<bool> updateEvent(EventModel event) async =>
      _eventRepository.updateEvent(event);

  Future<bool> deleteEvent(String id) async => _eventRepository.deleteEvent(id);

  Future<List<EventModel>?> getEvents() async => _eventRepository.getEvents();

  Future<List<EventModel>?> getEventsByTitle(String title) async =>
      _eventRepository.getEventsByTitle(title);

  Future<List<EventModel>?> getEventsByUser(String user) async =>
      _eventRepository.getEventsByUser(user);
}

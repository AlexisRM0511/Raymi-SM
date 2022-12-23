import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_repository.dart';

class EventController {
  final EventRepository _eventRepository;

  EventController(this._eventRepository);

  Future<List<EventModel>?> getEvents() async => _eventRepository.getEvents();

  Future<EventModel?> getEventById(String id) async =>
      _eventRepository.getEventById(id);

  Future<void> createEvent(EventModel event) async =>
      _eventRepository.createEvent(event);

  Future<String?> updateEvent(EventModel event) async =>
      _eventRepository.updateEvent(event);

  Future<String?> deleteEvent(String id) async => _eventRepository.deleteEvent(id);

  Future<List<EventModel>?> getEventsByTitle(String title) async =>
      _eventRepository.getEventsByTitle(title);

  Future<List<EventModel>?> getEventsByUser(String user) async =>
      _eventRepository.getEventsByUser(user);
}

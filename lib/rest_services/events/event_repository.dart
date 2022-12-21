import '/rest_services/events/event_model.dart';

abstract class EventRepository {
  Future<List<EventModel>?> getEvents();

  Future<EventModel?> getEventById(String id);

  Future<EventModel?> createEvent(EventModel event);

  Future<String?> updateEvent(EventModel event);

  Future<String?> deleteEvent(String id);

  Future<List<EventModel>?> getEventsByTitle(String title);

  Future<List<EventModel>?> getEventsByUser(String user);
}

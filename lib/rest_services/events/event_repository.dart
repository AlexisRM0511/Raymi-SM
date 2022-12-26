import '/rest_services/events/event_model.dart';

abstract class EventRepository {
  Future<void> createEvent(EventModel event);

  Future<EventModel?> readEvent(String id);

  Future<bool> updateEvent(EventModel event);

  Future<bool> deleteEvent(String id);

  Future<List<EventModel>?> getEvents();

  Future<List<EventModel>?> getEventsByTitle(String title);

  Future<List<EventModel>?> getEventsByUser(String user);
}

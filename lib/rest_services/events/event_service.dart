import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raymism/rest_services/users/user_service.dart';
import 'package:raymism/shared/constants.dart';
import 'package:raymism/shared/utils.dart';
import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_repository.dart';

class EventService implements EventRepository {
  final CollectionReference collectionEvents =
      FirebaseFirestore.instance.collection(Constants.collectionEvents);

  @override
  Future<void> createEvent(EventModel event) async {
    try {
      UserService userService = UserService();
      event.createdAt = Timestamp.now();
      event.user = (await userService.getCurrentUser())?.username;
      event.id = collectionEvents.doc().id;
      await collectionEvents.doc(event.id).set(event.toJson());
      Utils.alertSuccess(Constants.eventCreated);
    } catch (e) {
      Utils.alertError(Constants.errorCreatingEvent);
    }
  }

  @override
  Future<EventModel?> readEvent(String id) async {
    return await collectionEvents.doc(id).get().then((value) {
      return EventModel.fromJson(value.data() as Map<String, dynamic>);
    }).catchError((e) {
      Utils.alertError(Constants.errorGettingEvent);
    });
  }

  @override
  Future<bool> updateEvent(EventModel event) async {
    try {
      await collectionEvents.doc(event.id).update(event.toJson());
      Utils.alertSuccess(Constants.eventUpdated);
      return true;
    } catch (e) {
      Utils.alertError(Constants.errorUpdatingEvent);
      return false;
    }
  }

  @override
  Future<bool> deleteEvent(String id) async {
    try {
      await collectionEvents.doc(id).delete();
      Utils.alertSuccess(Constants.eventDeleted);
      return true;
    } catch (e) {
      Utils.alertError(Constants.errorDeletingEvent);
      return false;
    }
  }

  @override
  Future<List<EventModel>?> getEvents() async {
    return await collectionEvents.get().then((querySnapshot) {
      List<EventModel> events = [];
      for (var element in querySnapshot.docs) {
        events.add(EventModel.fromJson(element.data() as Map<String, dynamic>));
      }
      events.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      Utils.alertSuccess(Constants.eventsGetted);
      return events;
    }).catchError((error) {
      Utils.alertError(Constants.errorGettingEvents);
    });
  }

  @override
  Future<List<EventModel>?> getEventsByTitle(String title) async {
    return await collectionEvents
        .where("title", isEqualTo: title)
        .get()
        .then((querySnapshot) {
      List<EventModel> events = [];
      for (var element in querySnapshot.docs) {
        events.add(EventModel.fromJson(element.data() as Map<String, dynamic>));
      }
      events.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      Utils.alertSuccess(Constants.eventsGetted);
      return events;
    }).catchError((error) {
      Utils.alertError(Constants.errorGettingEvents);
    });
  }

  @override
  Future<List<EventModel>?> getEventsByUser(String user) async {
    return await collectionEvents
        .where("user", isEqualTo: user)
        .get()
        .then((querySnapshot) {
      List<EventModel> events = [];
      for (var element in querySnapshot.docs) {
        events.add(EventModel.fromJson(element.data() as Map<String, dynamic>));
      }
      events.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      Utils.alertSuccess(Constants.eventsGetted);
      return events;
    }).catchError((error) {
      Utils.alertError(Constants.errorGettingEvents);
    });
  }
}

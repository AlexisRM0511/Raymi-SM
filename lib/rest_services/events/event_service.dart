import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'package:raymism/shared/constants.dart';
import 'package:raymism/shared/utils.dart';
import '/rest_services/response_data.dart';
import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_repository.dart';

class EventService implements EventRepository {
  final CollectionReference collectionEvents =
      FirebaseFirestore.instance.collection(Constants.collectionEvents);

  @override
  Future<List<EventModel>?> getEvents() async {
    List<EventModel> events = [];
    await collectionEvents.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        events.add(EventModel.fromJson(result.data() as Map<String, dynamic>));
      }
    });
  }

  @override
  Future<EventModel?> getEventById(String id) async {}

  @override
  Future<void> createEvent(EventModel event) async {
    try {
      event.createdAt = Timestamp.now();
      event.id = collectionEvents.doc().id;
      await collectionEvents.doc(event.id).set(event.toJson());
      Utils.alertSuccess("Evento creado exitosamente");
    } catch (e) {
      Utils.alertError("Error al crear el evento");
    }
  }

  @override
  Future<String?> updateEvent(EventModel event) async {}

  @override
  Future<String?> deleteEvent(String id) async {}

  @override
  Future<List<EventModel>?> getEventsByTitle(String title) async {}

  @override
  Future<List<EventModel>?> getEventsByUser(String user) async {}
}

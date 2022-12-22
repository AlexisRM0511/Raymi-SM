import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'package:raymism/shared/constants.dart';
import '/rest_services/response_data.dart';
import '/rest_services/events/event_model.dart';
import '/rest_services/events/event_repository.dart';

class EventService implements EventRepository {
  final String apiUrl = "https://limachay.herokuapp.com/event";
  final CollectionReference collectionEvents =
  FirebaseFirestore.instance.collection(Constants.collectionEvents);

  @override
  Future<List<EventModel>?> getEvents() async {
    List<EventModel> events = [];
    await collectionEvents.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        print(result.data().toString());
        // events.add(EventModel.fromJson(result.data()));
      }
    });

  }

  @override
  Future<EventModel?> getEventById(String id) async {
    Uri url = Uri.parse('$apiUrl/$id');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      return EventModel.fromJson(responseData.data);
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<EventModel?> createEvent(EventModel event) async {
    Uri url = Uri.parse('$apiUrl/create');
    ResponseData responseData = ResponseData.fromJson(
        json.decode((await https.post(url, body: event.toJson())).body));
    if (responseData.status == 200) {
      return EventModel.fromJson(responseData.data);
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<String?> updateEvent(EventModel event) async {
    Uri url = Uri.parse('$apiUrl/update/${event.id}');
    ResponseData responseData = ResponseData.fromJson(
        json.decode((await https.put(url, body: event.toJson())).body));
    if (responseData.status == 200) {
      return "Datos actualizados correctamente";
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<String?> deleteEvent(String id) async {
    Uri url = Uri.parse('$apiUrl/delete/$id');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.delete(url)).body));
    if (responseData.status == 200) {
      return "Usuario eliminado correctamente";
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<List<EventModel>?> getEventsByTitle(String title) async {
    Uri url = Uri.parse('$apiUrl/title/$title');
    ResponseData responseData =
    ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      List<EventModel> events = (responseData.data as List)
          .map((event) => EventModel.fromJson(event))
          .toList();
      return events;
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  @override
  Future<List<EventModel>?> getEventsByUser(String user) async {
    Uri url = Uri.parse('$apiUrl/user/$user');
    ResponseData responseData =
        ResponseData.fromJson(json.decode((await https.get(url)).body));
    if (responseData.status == 200) {
      List<EventModel> events = (responseData.data as List)
          .map((event) => EventModel.fromJson(event))
          .toList();
      return events;
    } else {
      Fluttertoast.showToast(
          msg: responseData.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }
}

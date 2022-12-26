import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raymism/shared/utils.dart';
import '/rest_services/events/event_controller.dart';
import '/rest_services/events/event_service.dart';
import '../../../../rest_services/events/event_model.dart';

part '../../event/bloc/event_event.dart';

part '../../event/bloc/event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventState());
  final EventController _eventController = EventController(EventService());

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is LeadingIconButtonPressed) {
      yield EventState(isLoading: false);
      Navigator.pop(event.context);
    }

    if (event is AddPhotoButtonPressedEvent) {
      XFile? image;
      await showDialog(
          context: event.context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Cargar Imagen'),
                content: const Text(
                    '¿Deseas cargar la imagen desde la galería o desde la camara?'),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Camera'),
                      onPressed: () async => await ImagePicker()
                          .pickImage(source: ImageSource.camera)
                          .then((value) =>
                              {image = value, Navigator.pop(context)})),
                  TextButton(
                      child: const Text('Galería'),
                      onPressed: () async {
                        await ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((value) =>
                                {image = value, Navigator.pop(context)});
                      })
                ]);
          });
      if (image != null) {
        yield EventState(photo: image!.path);
      }
    }

    if (event is RemovePhotoButtonPressedEvent) {
      yield EventState(photo: '');
    }

    if (event is EventButtonPressed && event.formKey.currentState!.validate()) {
      yield EventState(
          user: FirebaseAuth.instance.currentUser!.uid,
          title: event.title,
          description: event.description,
          dateAndTime: event.dateAndTime,
          location: event.location,
          photo: event.photo,
          isLoading: true);

      EventModel eventModel = EventModel(
          title: state.title,
          description: state.description,
          dateAndTime: state.dateAndTime,
          location: state.location,
          status: -1,
          photo: state.photo);
      if (state.photo != '') {
        await (await FirebaseStorage.instance
                .ref()
                .child(
                    'event_images/${state.title}_${state.user}_${DateTime.now().millisecondsSinceEpoch}')
                .putFile(File(state.photo)))
            .ref
            .getDownloadURL()
            .then((value) => eventModel.photo = value)
            .catchError(
                (error) => Utils.alertError("Error al cargar la imagen"));
      }
      await _eventController
          .createEvent(eventModel)
          .then((value) => Navigator.pop(event.context));
      yield EventState(isLoading: false);
    }
  }
}

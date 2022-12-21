import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '/rest_services/events/event_controller.dart';
import '/rest_services/events/event_service.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../rest_services/events/event_model.dart';

part '../../event/bloc/event_event.dart';
part '../../event/bloc/event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventState());
  final EventController _eventController = EventController(EventService());
  final UserController _userController = UserController(UserService());
  final SpeechToText speechToText = SpeechToText();

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is LeadingIconButtonPressed) {
      yield EventState(
          user: '',
          title: '',
          description: '',
          dateAndTime: '',
          location: '',
          photo: '',
          status: -1,
          isLoading: false);
      Navigator.pop(event.context);
    }

    if (event is DescriptionTextEvent) {
      yield EventState(
          description: event.description,
          isLoading: false,
          isListening: state.isListening);
      if (!event.isActivated) {
        speechToText.stop();
        yield EventState(
            description: state.description,
            isLoading: false,
            isListening: !state.isListening);
      }
    }

    if (event is AddPhotoButtonPressedEvent) {
      XFile? image;
      int value = -1;
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
                    onPressed: () async {
                      Navigator.pop(context);
                      value = 1;
                    }),
                TextButton(
                  child: const Text('Galería'),
                  onPressed: () async {
                    Navigator.pop(context);
                    value = 0;
                  },
                )
              ],
            );
          });

      image = (value == 1)
          ? await ImagePicker().pickImage(source: ImageSource.camera)
          : (value == 0)
              ? await ImagePicker().pickImage(source: ImageSource.gallery)
              : null;

      if (image != null) {
        yield EventState(
            photo: image.path,
            isListening: false,
            description: state.description);
      }
    }

    if (event is RemovePhotoButtonPressedEvent) {
      yield EventState(
          photo: '', isListening: false, description: state.description);
    }

    if (event is DescriptionIconButtonPressedEvent) {
      yield EventState(
          isListening: !state.isListening,
          isLoading: false,
          description: event.description);
      if (state.isListening) {
        bool available = await speechToText
            .initialize(
                onStatus: (val) => Fluttertoast.showToast(
                    msg: 'Estado: $val',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0),
                onError: (val) => Fluttertoast.showToast(
                    msg: 'Error: $val',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0))
            .catchError((_) async {
          Fluttertoast.showToast(
              msg: 'Error al inicializar el reconocimiento de voz',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        });
        if (available) {
          speechToText.listen(onResult: (val) {
            add(DescriptionTextEvent(
                description: val.recognizedWords,
                isActivated: speechToText.isListening));
          });
        } else {
          Fluttertoast.showToast(
              msg: "El dispositivo no soporta la función de voz",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          yield EventState(
              isListening: !state.isListening,
              isLoading: false,
              description: state.description);
        }
      } else {
        speechToText.stop();
      }
    }

    if (event is EventButtonPressed) {
      if (event.formKey.currentState!.validate()) {
        yield EventState(
            user: event.user,
            title: event.title,
            description: event.description,
            dateAndTime: event.dateAndTime,
            location: event.location,
            photo: event.photo,
            status: event.status,
            isKnown: event.isKnown,
            isLoading: true);

        User? userFirebase = FirebaseAuth.instance.currentUser;
        UserModel? user =
            await _userController.getUserById(userFirebase!.uid);
        String link = '';
        bool isUploaded = false;
        if (state.photo != '') {
          try {
            File file = File(state.photo);
            link = await (await FirebaseStorage.instance
                    .ref()
                    .child(
                        'event_images/${state.title}_${user!.id}_${DateTime.now().millisecondsSinceEpoch}')
                    .putFile(file))
                .ref
                .getDownloadURL();
            isUploaded = true;
          } on FirebaseException catch (_) {
            Fluttertoast.showToast(
                msg: 'Error al cargar la imagen',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          isUploaded = true;
        }

        if (user != null && isUploaded) {
          EventModel? eventModel = await _eventController.createEvent(EventModel(
              user: user.id,
              title: state.title,
              description: state.description,
              dateAndTime: state.dateAndTime,
              location: state.location,
              photo: link,
              status: state.status,
              isKnown: state.isKnown));

          if (eventModel != null) {
            yield EventState(isListening: false, isLoading: false);
            Fluttertoast.showToast(
                msg: 'Denuncia registrada con éxito',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(event.context);
          } else {
            yield EventState(isListening: false, isLoading: false);
            Fluttertoast.showToast(
                msg: 'Error al registrar la denuncia',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          yield EventState(isListening: false, isLoading: false);
          Fluttertoast.showToast(
              msg: 'Error al registrar la denuncia',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
  }
}

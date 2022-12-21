import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '/rest_services/sues/sue_controller.dart';
import '/rest_services/sues/sue_model.dart';
import '/rest_services/sues/sue_service.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'sue_edit_event.dart';
part 'sue_edit_state.dart';

class SueEditBloc extends Bloc<SueEditEvent, SueEditState> {
  SueEditBloc() : super(SueEditState());
  final SueController _sueController = SueController(SueService());
  final SpeechToText speechToText = SpeechToText();

  @override
  Stream<SueEditState> mapEventToState(SueEditEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      yield SueEditState(
        user: '',
        title: '',
        description: '',
        dateAndTime: '',
        location: '',
        photo: '',
        status: -1,
        isKnown: false,
        isLoading: false,
      );
      Navigator.pop(event.context);
    }

    if (event is SueEditButtonPressedEvent) {
      yield SueEditState(
        user: event.user,
        title: event.title,
        description: event.description,
        dateAndTime: event.dateAndTime,
        location: event.location,
        photo: event.photo,
        status: event.status,
        isKnown: event.isKnown,
        isLoading: true,
      );

      String link = '';
      if (state.photo != '') {
        try {
          File file = File(state.photo);
          link = await (await FirebaseStorage.instance
                  .ref()
                  .child(
                      'sue_images/${state.title}_${state.user.split("|")[1]}_${DateTime.now().millisecondsSinceEpoch}')
                  .putFile(file))
              .ref
              .getDownloadURL();
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
      }
      String? messageConfirm = await _sueController.updateSue(SueModel(
        id: event.id,
        user: state.user.split("|")[1],
        title: state.title,
        description: state.description,
        dateAndTime: state.dateAndTime,
        location: state.location,
        photo: link,
        status: state.status,
        isKnown: state.isKnown,
      ));
      if (messageConfirm != null) {
        Fluttertoast.showToast(
            msg: 'Denuncia actualizada con éxito',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(event.context);
      } else {
        Fluttertoast.showToast(
            msg: 'Error al actualizar la denuncia',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      yield SueEditState(isLoading: false);
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
        yield SueEditState(
            photo: image.path,
            isListening: false,
            description: state.description);
      }
    }

    if (event is DescriptionTextEvent) {
      yield SueEditState(
          description: event.description,
          isLoading: false,
          isListening: state.isListening);
      if (!event.isActivated) {
        speechToText.stop();
        yield SueEditState(
            description: state.description,
            isLoading: false,
            isListening: !state.isListening);
      }
    }

    if (event is DescriptionIconButtonPressedEvent) {
      yield SueEditState(
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
          yield SueEditState(
              isListening: !state.isListening,
              isLoading: false,
              description: state.description);
        }
      } else {
        speechToText.stop();
        yield SueEditState(
            description: state.description,
            isLoading: false,
            isListening: !state.isListening);
      }
    }

    if (event is RemovePhotoButtonPressedEvent) {
      yield SueEditState(
          photo: '', isListening: false, description: state.description);
    }
  }
}

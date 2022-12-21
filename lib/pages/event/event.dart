import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/event/bloc/event_bloc.dart';
import '/pages/event/widgets/app_bar.dart';
import '/pages/event/widgets/button_form.dart';
import '/pages/event/widgets/checkbox_form.dart';
import '/pages/event/widgets/input_date_time_form.dart';
import '/pages/event/widgets/input_description_form.dart';
import '/pages/event/widgets/input_location_form.dart';
import '/pages/event/widgets/input_photo_form.dart';
import '/pages/event/widgets/input_title_form.dart';
import '/pages/event/widgets/spinner_loading.dart';
import '/pages/event/widgets/text_input_form.dart';
import '/pages/event/widgets/text_event_form.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _checkboxController = TextEditingController();

  static final _formEventKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
        appBar: AppBarEvent(
            onPressed: () =>
                eventBloc.add(LeadingIconButtonPressed(context: context))),
        body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                      child: Form(
                          key: _formEventKey,
                          child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Column(children: [
                                const TextEventForm(text: "D e n u n c i a r"),
                                const TextInputEventForm(text: "Título"),
                                InputTitleForm(
                                    text: "Título",
                                    textController: _titleController),
                                const TextInputEventForm(text: "Descripción"),
                                InputDescriptionForm(
                                    text: "Descripción",
                                    textController: _descriptionController,
                                    stateText: state.description,
                                    isListening: state.isListening,
                                    onPressed: () => eventBloc.add(
                                        DescriptionIconButtonPressedEvent(
                                            description:
                                                "${state.description} "))),
                                const TextInputEventForm(text: "Fecha y Hora"),
                                InputDateAndTimeForm(
                                    text: "Fecha y Hora",
                                    textController: _dateAndTimeController),
                                const TextInputEventForm(text: "Ubicación"),
                                InputLocationForm(
                                    text: "Ubicación",
                                    textController: _locationController),
                                const TextInputEventForm(text: "Foto"),
                                InputPhotoForm(
                                    text: "Foto",
                                    textController: state.photo,
                                    onPressedAnd: () => eventBloc.add(
                                        AddPhotoButtonPressedEvent(
                                            context: context)),
                                    onPressedDelete: () => eventBloc
                                        .add(RemovePhotoButtonPressedEvent())),
                                CheckBoxForm(
                                    text: "¿Conoces a la persona?",
                                    controller: _checkboxController),
                                ButtonForm(
                                    text: "Registrar Denuncia",
                                    onPressed: () => eventBloc.add(
                                        EventButtonPressed(
                                            context: context,
                                            formKey: _formEventKey,
                                            user: "",
                                            title: _titleController.text,
                                            description:
                                                _descriptionController.text,
                                            dateAndTime:
                                                _dateAndTimeController.text,
                                            location: _locationController.text,
                                            photo: state.photo,
                                            isKnown:
                                                (_checkboxController.text ==
                                                        "true")
                                                    ? true
                                                    : false,
                                            status: -1))),
                                const SizedBox(height: 20.0),
                              ]))))),
              SpinnerLoading(isLoading: state.isLoading)
            ],
          );
        }));
  }
}

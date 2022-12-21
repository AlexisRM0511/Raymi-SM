import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/event_edit/bloc/event_edit_bloc.dart';
import '/pages/event_edit/widgets/app_bar.dart';
import '/pages/event_edit/widgets/button_form.dart';
import '/pages/event_edit/widgets/checkbox_form.dart';
import '/pages/event_edit/widgets/input_date_time_form.dart';
import '/pages/event_edit/widgets/input_description_form.dart';
import '/pages/event_edit/widgets/input_location_form.dart';
import '/pages/event_edit/widgets/input_photo_form.dart';
import '/pages/event_edit/widgets/input_title_form.dart';
import '/pages/event_edit/widgets/spinner_loading.dart';
import '/pages/event_edit/widgets/text_input_form.dart';
import '/pages/event_edit/widgets/text_event_form.dart';
import '/rest_services/events/event_model.dart';

class EventEdit extends StatefulWidget {
  const EventEdit({Key? key}) : super(key: key);

  @override
  State<EventEdit> createState() => _EventState();
}

class _EventState extends State<EventEdit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _checkboxController = TextEditingController();

  static final _formEventKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EventModel params = ModalRoute.of(context)?.settings.arguments as EventModel;
    final eventEditBloc = BlocProvider.of<EventEditBloc>(context);
    _titleController.text = params.title ?? '';
    _descriptionController.text = params.description ?? '';
    _dateAndTimeController.text = params.dateAndTime ?? '';
    _locationController.text = params.location ?? '';
    _photoController.text = params.photo ?? '';
    _checkboxController.text = params.isKnown.toString();

    return Scaffold(
        appBar: AppBarEventEdit(
            onPressed: () => eventEditBloc
                .add(LeadingIconButtonPressedEvent(context: context))),
        body: BlocBuilder<EventEditBloc, EventEditState>(builder: (context, state) {
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
                                const TextEventForm(text: "Editar Denuncia"),
                                const TextInputEventForm(
                                  text: "Título",
                                ),
                                InputTitleForm(
                                    text: "Título",
                                    textController: _titleController),
                                const TextInputEventForm(text: "Descripción"),
                                InputDescriptionForm(
                                    text: "Descripción",
                                    textController: _descriptionController,
                                    stateText: state.description,
                                    isListening: state.isListening,
                                    onPressed: () => eventEditBloc.add(
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
                                    onPressedAnd: () => eventEditBloc.add(
                                        AddPhotoButtonPressedEvent(
                                            context: context)),
                                    onPressedDelete: () => eventEditBloc
                                        .add(RemovePhotoButtonPressedEvent())),
                                CheckBoxForm(
                                    text: "¿Conoces a la persona?",
                                    controller: _checkboxController),
                                ButtonForm(
                                    text: "Editar Denuncia",
                                    onPressed: () => eventEditBloc.add(
                                        EventEditButtonPressedEvent(
                                            context: context,
                                            formKey: _formEventKey,
                                            id: params.id.toString(),
                                            user: params.user.toString(),
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

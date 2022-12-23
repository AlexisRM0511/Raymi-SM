import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/components/inputs/input_text.dart';
import 'package:raymism/components/label.dart';
import 'package:raymism/components/spinner_loading.dart';
import 'package:raymism/shared/colors.dart';
import 'package:raymism/shared/constants.dart';
import '/pages/event/bloc/event_bloc.dart';
import '/pages/event/widgets/app_bar_event.dart';
import '/pages/event/widgets/text_event_form.dart';
import 'widgets/input_photo_form.dart';
import '../../components/inputs/input_date_picker.dart';
import '../../components/button.dart';

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
                      color: CustomColor.backgroundColor,
                      child: Form(
                          key: _formEventKey,
                          child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Column(children: [
                                const TextEventForm(
                                    text: Constants.registerEvent),
                                InputText(
                                    text: "Título",
                                    textController: _titleController),
                                InputText(
                                    text: "Descripción",
                                    textController: _descriptionController),
                                InputDatePicker(
                                    text: "Fecha y Hora",
                                    textController: _dateAndTimeController),
                                InputText(
                                    text: "Ubicación",
                                    textController: _locationController),
                                const Label(text: "Foto"),
                                InputPhotoForm(
                                    text: "Foto",
                                    textController: state.photo,
                                    onPressedAnd: () => eventBloc.add(
                                        AddPhotoButtonPressedEvent(
                                            context: context)),
                                    onPressedDelete: () => eventBloc
                                        .add(RemovePhotoButtonPressedEvent())),
                                Button(
                                    textColor: CustomColor.white,
                                    buttonColor: CustomColor.primaryColor,
                                    text: "Registrar Denuncia",
                                    onPressed: () => eventBloc.add(
                                        EventButtonPressed(
                                            context: context,
                                            formKey: _formEventKey,
                                            title: _titleController.text,
                                            description:
                                                _descriptionController.text,
                                            dateAndTime:
                                                _dateAndTimeController.text,
                                            location: _locationController.text,
                                            photo: state.photo))),
                                const SizedBox(height: 20.0),
                              ]))))),
              SpinnerLoading(isLoading: state.isLoading)
            ],
          );
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/sue/bloc/sue_bloc.dart';
import '/pages/sue/widgets/app_bar.dart';
import '/pages/sue/widgets/button_form.dart';
import '/pages/sue/widgets/checkbox_form.dart';
import '/pages/sue/widgets/input_date_time_form.dart';
import '/pages/sue/widgets/input_description_form.dart';
import '/pages/sue/widgets/input_location_form.dart';
import '/pages/sue/widgets/input_photo_form.dart';
import '/pages/sue/widgets/input_title_form.dart';
import '/pages/sue/widgets/spinner_loading.dart';
import '/pages/sue/widgets/text_input_form.dart';
import '/pages/sue/widgets/text_sue_form.dart';

class Sue extends StatefulWidget {
  const Sue({Key? key}) : super(key: key);

  @override
  State<Sue> createState() => _SueState();
}

class _SueState extends State<Sue> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _checkboxController = TextEditingController();

  static final _formSueKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sueBloc = BlocProvider.of<SueBloc>(context);

    return Scaffold(
        appBar: AppBarSue(
            onPressed: () =>
                sueBloc.add(LeadingIconButtonPressed(context: context))),
        body: BlocBuilder<SueBloc, SueState>(builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                      child: Form(
                          key: _formSueKey,
                          child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Column(children: [
                                const TextSueForm(text: "D e n u n c i a r"),
                                const TextInputSueForm(text: "Título"),
                                InputTitleForm(
                                    text: "Título",
                                    textController: _titleController),
                                const TextInputSueForm(text: "Descripción"),
                                InputDescriptionForm(
                                    text: "Descripción",
                                    textController: _descriptionController,
                                    stateText: state.description,
                                    isListening: state.isListening,
                                    onPressed: () => sueBloc.add(
                                        DescriptionIconButtonPressedEvent(
                                            description:
                                                "${state.description} "))),
                                const TextInputSueForm(text: "Fecha y Hora"),
                                InputDateAndTimeForm(
                                    text: "Fecha y Hora",
                                    textController: _dateAndTimeController),
                                const TextInputSueForm(text: "Ubicación"),
                                InputLocationForm(
                                    text: "Ubicación",
                                    textController: _locationController),
                                const TextInputSueForm(text: "Foto"),
                                InputPhotoForm(
                                    text: "Foto",
                                    textController: state.photo,
                                    onPressedAnd: () => sueBloc.add(
                                        AddPhotoButtonPressedEvent(
                                            context: context)),
                                    onPressedDelete: () => sueBloc
                                        .add(RemovePhotoButtonPressedEvent())),
                                CheckBoxForm(
                                    text: "¿Conoces a la persona?",
                                    controller: _checkboxController),
                                ButtonForm(
                                    text: "Registrar Denuncia",
                                    onPressed: () => sueBloc.add(
                                        SueButtonPressed(
                                            context: context,
                                            formKey: _formSueKey,
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

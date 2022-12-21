import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/sue_edit/bloc/sue_edit_bloc.dart';
import '/pages/sue_edit/widgets/app_bar.dart';
import '/pages/sue_edit/widgets/button_form.dart';
import '/pages/sue_edit/widgets/checkbox_form.dart';
import '/pages/sue_edit/widgets/input_date_time_form.dart';
import '/pages/sue_edit/widgets/input_description_form.dart';
import '/pages/sue_edit/widgets/input_location_form.dart';
import '/pages/sue_edit/widgets/input_photo_form.dart';
import '/pages/sue_edit/widgets/input_title_form.dart';
import '/pages/sue_edit/widgets/spinner_loading.dart';
import '/pages/sue_edit/widgets/text_input_form.dart';
import '/pages/sue_edit/widgets/text_sue_form.dart';
import '/rest_services/sues/sue_model.dart';

class SueEdit extends StatefulWidget {
  const SueEdit({Key? key}) : super(key: key);

  @override
  State<SueEdit> createState() => _SueState();
}

class _SueState extends State<SueEdit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _checkboxController = TextEditingController();

  static final _formSueKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SueModel params = ModalRoute.of(context)?.settings.arguments as SueModel;
    final sueEditBloc = BlocProvider.of<SueEditBloc>(context);
    _titleController.text = params.title ?? '';
    _descriptionController.text = params.description ?? '';
    _dateAndTimeController.text = params.dateAndTime ?? '';
    _locationController.text = params.location ?? '';
    _photoController.text = params.photo ?? '';
    _checkboxController.text = params.isKnown.toString();

    return Scaffold(
        appBar: AppBarSueEdit(
            onPressed: () => sueEditBloc
                .add(LeadingIconButtonPressedEvent(context: context))),
        body: BlocBuilder<SueEditBloc, SueEditState>(builder: (context, state) {
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
                                const TextSueForm(text: "Editar Denuncia"),
                                const TextInputSueForm(
                                  text: "Título",
                                ),
                                InputTitleForm(
                                    text: "Título",
                                    textController: _titleController),
                                const TextInputSueForm(text: "Descripción"),
                                InputDescriptionForm(
                                    text: "Descripción",
                                    textController: _descriptionController,
                                    stateText: state.description,
                                    isListening: state.isListening,
                                    onPressed: () => sueEditBloc.add(
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
                                    onPressedAnd: () => sueEditBloc.add(
                                        AddPhotoButtonPressedEvent(
                                            context: context)),
                                    onPressedDelete: () => sueEditBloc
                                        .add(RemovePhotoButtonPressedEvent())),
                                CheckBoxForm(
                                    text: "¿Conoces a la persona?",
                                    controller: _checkboxController),
                                ButtonForm(
                                    text: "Editar Denuncia",
                                    onPressed: () => sueEditBloc.add(
                                        SueEditButtonPressedEvent(
                                            context: context,
                                            formKey: _formSueKey,
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

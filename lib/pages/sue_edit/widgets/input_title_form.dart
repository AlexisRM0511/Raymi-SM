import 'package:flutter/material.dart';

class InputTitleForm extends StatefulWidget {
  final String text;
  final TextEditingController textController;

  const InputTitleForm({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  State<InputTitleForm> createState() => _InputTitleFormState();
}

class _InputTitleFormState extends State<InputTitleForm> {
  get text => widget.text;

  get textController => widget.textController;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.09,
            child: DropdownButtonFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                alignLabelWithHint: true,
                filled: true,
                contentPadding: const EdgeInsets.only(left: 14.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: textController.text,
              items: const [
                DropdownMenuItem(
                    value: 'Hecho en Establec. Comerc.',
                    child: Text('Hecho en Establec. Comerc.')),
                DropdownMenuItem(
                    value: 'Hecho a Transeunte en Establec. Comerc.',
                    child: Text('Hecho a Transeunte en Establec. Comerc.')),
                DropdownMenuItem(
                    value: 'Hecho a Transeunte en la Via Pública',
                    child: Text('Hecho a Transeunte en la Via Pública')),
                DropdownMenuItem(
                    value: 'Robo de Autopartes / Accesorios',
                    child: Text('Robo de Autopartes / Accesorios')),
                DropdownMenuItem(
                    value: 'Robo de Vehículos',
                    child: Text('Robo de Vehículos')),
                DropdownMenuItem(
                    value: 'Robo de Vehículos Menores',
                    child: Text('Robo de Vehículos Menores')),
                DropdownMenuItem(
                    value: 'Robo a Vivienda Multifamiliar',
                    child: Text('Robo a Vivienda Multifamiliar')),
                DropdownMenuItem(
                    value: 'Robo a Vivienda Unifamiliar',
                    child: Text('Robo a Vivienda Unifamiliar'))
              ],
              onChanged: (value) {
                if (value != null) {
                  textController.text = value.toString();
                } else {}
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor seleccione un tipo de delito';
                }
                return null;
              },
            )));
    /*child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: text,
                    contentPadding: const EdgeInsets.only(left: 14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Por favor ingrese un título válido';
                  }
                  return null;
                })));*/
  }
}

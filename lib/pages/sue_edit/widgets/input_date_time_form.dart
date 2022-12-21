import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDateAndTimeForm extends StatefulWidget {
  final String text;
  final TextEditingController textController;

  const InputDateAndTimeForm({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  State<InputDateAndTimeForm> createState() => _InputDateAndTimeFormState();
}

class _InputDateAndTimeFormState extends State<InputDateAndTimeForm> {
  get textController => widget.textController;

  get text => widget.text;

  @override
  Widget build(BuildContext context) {

    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.09,
            child: TextFormField(
                readOnly: true,
                onTap: () async {
                  // capturar la fecha y hora
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (picked != null) {
                    setState(() {
                      textController.text =
                          DateFormat('dd/MM/yyyy').format(picked);
                    });
                  }
                  //capturar la hora
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      textController.text =
                          textController.text + ' ' + time.format(context);
                    });
                  }
                },
                textAlignVertical: TextAlignVertical.center,
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
                    ),
                    suffixIcon:
                        const Icon(Icons.calendar_month, color: Colors.grey)),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Por favor ingrese una fecha y hora válida';
                  }
                  return null;
                })));
  }
}

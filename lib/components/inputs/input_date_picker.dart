import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raymism/components/label.dart';
import 'package:raymism/shared/colors.dart';

class InputDatePicker extends StatefulWidget {
  final String text;
  final TextEditingController textController;

  const InputDatePicker({
    Key? key,
    required this.text,
    required this.textController,
  }) : super(key: key);

  @override
  State<InputDatePicker> createState() => _InputDatePickerFormState();
}

class _InputDatePickerFormState extends State<InputDatePicker> {
  get textController => widget.textController;

  get text => widget.text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(children: [
              Label(text: text),
              TextFormField(
                  readOnly: true,
                  onTap: () async {
                    // capturar la fecha y hora
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 100));
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
                  style: const TextStyle(color: CustomColor.black),
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: CustomColor.white,
                      hintText: text,
                      contentPadding: const EdgeInsets.only(left: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColor.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: CustomColor.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: const Icon(Icons.calendar_month,
                          color: CustomColor.black)),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Por favor ingrese una fecha y hora válida';
                    }
                    return null;
                  })
            ])));
  }
}

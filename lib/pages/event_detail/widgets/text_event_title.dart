import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextEventTitle extends StatefulWidget {
  final String title;
  final int status;
  final Function onPressed;
  final String idUser;

  const TextEventTitle(
      {Key? key,
      required this.idUser,
      required this.title,
      required this.status,
      required this.onPressed})
      : super(key: key);

  @override
  State<TextEventTitle> createState() => _TextEventTitleState();
}

class _TextEventTitleState extends State<TextEventTitle> {
  get status => widget.status;

  get title => widget.title;

  get onPressed => widget.onPressed;

  get idUser => widget.idUser;

  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _isButtonDisabled =
            (prefs.getString('idUser') == idUser.toString().split("|")[1])
                ? true
                : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(title, style: style)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                      status == 1
                          ? Icons.check_circle_sharp
                          : status == 0
                              ? Icons.remove_circle_sharp
                              : Icons.add_circle_sharp,
                      color: status == 1
                          ? Colors.lightGreen
                          : status == 0
                              ? Colors.redAccent
                              : Colors.orangeAccent,
                      size: 25.0),
                  _isButtonDisabled
                      ? IconButton(
                          disabledColor: Colors.grey,
                          color: Colors.black,
                          icon: const Icon(Icons.create_rounded, size: 25.0),
                          onPressed: status == -1 ? () => onPressed() : null,
                        )
                      : Container()
                ])
          ]),
    );
  }
}

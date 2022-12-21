import 'package:flutter/material.dart';

class EventsStatistics extends StatefulWidget {
  final int eventMade;
  final int eventApproved;

  const EventsStatistics(
      {required this.eventMade, required this.eventApproved, Key? key})
      : super(key: key);

  @override
  State<EventsStatistics> createState() => _EventsStatisticsState();
}

class _EventsStatisticsState extends State<EventsStatistics> {
  get eventMade => widget.eventMade;

  get eventApproved => widget.eventApproved;

  @override
  Widget build(BuildContext context) {
    TextStyle styleNumber =
        const TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
    TextStyle styleText =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

    final double size = (MediaQuery.of(context).size.width * 0.8 - 120.0) / 2.0;

    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: size,
                    child: Text(eventMade.toString(), style: styleNumber)),
                SizedBox(
                    width: size, child: Text('Realizadas', style: styleText))
              ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: size,
                    child: Text(eventApproved.toString(), style: styleNumber)),
                SizedBox(
                    width: size, child: Text('Aprobadas', style: styleText))
              ])
        ]));
  }
}

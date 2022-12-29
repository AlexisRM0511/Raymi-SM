import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/shared/colors.dart';
import '/pages/event_detail/widgets/image_event.dart';
import '/pages/event_detail/widgets/text_event_data.dart';
import '/pages/event_detail/widgets/text_event_info.dart';
import '/pages/event_detail/widgets/text_event_title.dart';

import '../../rest_services/events/event_model.dart';
import 'bloc/event_detail_bloc.dart';
import 'widgets/app_bar.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({Key? key}) : super(key: key);

  @override
  State<EventDetail> createState() => _SearchPageState();
}

class _SearchPageState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    EventModel params =
        ModalRoute.of(context)?.settings.arguments as EventModel;
    final eventDetailBloc = BlocProvider.of<EventDetailBloc>(context);

    return Scaffold(
        appBar: AppBarEventDetail(
            onPressed: () => eventDetailBloc
                .add(LeadingIconButtonPressedEvent(context: context)),
            title: params.title!),
        body: BlocBuilder<EventDetailBloc, EventDetailState>(
            builder: (context, state) {
          return Stack(children: [
            SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: CustomColor.backgroundColor,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(children: [
                          ImageEvent(image: params.photo!),
                          TextEventTitle(
                              idUser: params.user!,
                              title: params.title!,
                              status: params.status!,
                              onPressed: () => eventDetailBloc.add(
                                  GoEventEditEvent(
                                      context: context, event: params))),
                          const TextEventInfo(text: 'Descripción:'),
                          TextEventData(text: params.description!),
                          const TextEventInfo(text: 'Fecha y Hora:'),
                          TextEventData(text: params.dateAndTime!),
                          const TextEventInfo(text: 'Ubicación:'),
                          TextEventData(text: params.location!),
                          const TextEventInfo(text: 'Creado por:'),
                          TextEventData(text: params.user!.split("|")[0])
                        ]))))
          ]);
        }));
  }
}

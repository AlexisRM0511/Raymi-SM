import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/shared/colors.dart';
import 'package:raymism/shared/constants.dart';
import '/pages/home/bloc/home_bloc.dart';
import '/rest_services/events/event_model.dart';

class EventList extends StatefulWidget {
  final List<EventModel> eventModelList;
  final bool isLoading;

  const EventList(
      {required this.eventModelList, required this.isLoading, Key? key})
      : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  get eventModelList => widget.eventModelList;

  get isLoading => widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final double sizeReference =
        700.0 / MediaQuery.of(context).size.longestSide;
    return FutureBuilder<List<EventModel>?>(builder: (context, snapshot) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (eventModelList.isEmpty) {
        return const Center(child: Text(Constants.recordNotFound));
      } else {
        return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: eventModelList.length,
            padding: const EdgeInsets.all(8.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              EventModel event = eventModelList.elementAt(index);
              return InkWell(
                  onTap: () => homeBloc
                      .add(GoEventDetailEvent(context: context, event: event)),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150.0 * sizeReference,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey, width: 2.0)),
                      child: Row(children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                            child: (event.photo!.isEmpty)
                                ? Image.asset('assets/image_not_found.png',
                                    width: (MediaQuery.of(context).size.width *
                                            0.3) -
                                        20.0,
                                    height: 150.0 * sizeReference,
                                    fit: BoxFit.cover,
                                    alignment: FractionalOffset.center)
                                : Image.network(event.photo!.toString(),
                                    width: (MediaQuery.of(context).size.width *
                                            0.3) -
                                        20.0,
                                    height: 150.0 * sizeReference,
                                    fit: BoxFit.cover,
                                    alignment: FractionalOffset.center)),
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0)),
                                color: CustomColor.primaryColor),
                            width: (MediaQuery.of(context).size.width * 0.7) -
                                20.0,
                            height: 200.0 * sizeReference,
                            padding: const EdgeInsets.all(5.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${event.location}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0 * sizeReference,
                                          color: CustomColor.white2),
                                    ),
                                    SizedBox(height: 10.0 * sizeReference),
                                    Text('${event.title}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 24.0 * sizeReference,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColor.white)),
                                    SizedBox(height: 10.0 * sizeReference),
                                    Text(
                                        'Creado por ${(event.user != "") ? event.user!.split("|")[0] : 'N/A'}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16.0 * sizeReference,
                                            color: CustomColor.white2))
                                  ]),
                            ))
                      ])));
            });
      }
    });
  }
}

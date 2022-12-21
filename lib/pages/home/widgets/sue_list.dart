import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/home/bloc/home_bloc.dart';
import '/rest_services/sues/sue_model.dart';

class SueList extends StatefulWidget {
  final List<SueModel> sueModelList;
  final String message;
  final bool isError;
  final bool isLoading;

  const SueList(
      {required this.sueModelList,
      required this.message,
      required this.isError,
      required this.isLoading,
      Key? key})
      : super(key: key);

  @override
  State<SueList> createState() => _SueListState();
}

class _SueListState extends State<SueList> {
  get sueModelList => widget.sueModelList;

  get message => widget.message;

  get isLoading => widget.isLoading;

  get isError => widget.isError;

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final double sizeReference =
        700.0 / MediaQuery.of(context).size.longestSide;
    return FutureBuilder<List<SueModel>?>(builder: (context, snapshot) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (isError) {
        return Center(child: Text('Aviso: $message'));
      } else if (sueModelList.isEmpty) {
        return Center(child: Text('$message'));
      } else {
        return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: sueModelList.length,
            padding: const EdgeInsets.all(8.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              SueModel sue = sueModelList.elementAt(index);
              return InkWell(
                  onTap: () => homeBloc
                      .add(GoSueDetailEvent(context: context, sue: sue)),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black, width: 2.0)),
                      child: Row(children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                            child: (sue.photo!.isEmpty)
                                ? Image.asset('assets/image_not_found.png',
                                    width: (MediaQuery.of(context).size.width *
                                            0.4) -
                                        20.0,
                                    height: 150.0 * sizeReference,
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.center)
                                : Image.network(sue.photo!.toString(),
                                    width: (MediaQuery.of(context).size.width *
                                            0.4) -
                                        20.0,
                                    height: 150.0 * sizeReference,
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.center)),
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0)),
                                color: Color(0xFF79E070)),
                            width: (MediaQuery.of(context).size.width * 0.6) -
                                20.0,
                            height: 150.0 * sizeReference,
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${sue.location}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.0 * sizeReference,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 10.0 * sizeReference),
                                  Text('${sue.title}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20.0 * sizeReference,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  SizedBox(height: 10.0 * sizeReference),
                                  Text('${sue.description}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0 * sizeReference,
                                          color: Colors.black)),
                                  SizedBox(height: 10.0 * sizeReference),
                                  Text(
                                      'Reportado por ${(sue.user != "") ? sue.user!.split("|")[0] : 'N/A'}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.0 * sizeReference,
                                          color: Colors.black))
                                ]))
                      ])));
            });
      }
    });
  }
}

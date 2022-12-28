import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/components/event_list.dart';
import '/pages/search/bloc/search_bloc.dart';
import '/pages/search/widgets/app_bar.dart';
import '/pages/search/widgets/input_search.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
        appBar: AppBarSearch(
            onPressed: () =>
                searchBloc.add(LeadingIconButtonPressedEvent(context: context))),
        body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Stack(children: [
            SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(children: [
                          InputSearch(
                              hint: "Buscar",
                              controller: _searchController,
                              onPressed: () => searchBloc.add(
                                  SearchEventsEvent(search: _searchController.text))),
                          const SizedBox(height: 10.0),
                          EventList(
                              eventModelList: state.eventModelList,
                              isLoading: state.isLoading)
                        ]))))
          ]);
        }));
  }
}

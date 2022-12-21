import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/sues/sue_controller.dart';
import '/rest_services/sues/sue_model.dart';
import '/rest_services/sues/sue_service.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());
  final SueController _sueController = SueController(SueService());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is LeadingIconButtonPressedEvent) {
      yield SearchState(
          isLoading: false,
          isError: false,
          message: "Escriba el título del delito a buscar",
          sueModelList: const []);
      Navigator.pop(event.context);
    }

    if (event is GoSueDetailEvent) {
      Navigator.pushNamed(event.context, '/sue_detail',arguments: event.sue);
      Fluttertoast.showToast(
          msg: 'Denunciar ${event.sue.title}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (event is SearchSuesEvent) {
      if (event.search.isEmpty) {
        Fluttertoast.showToast(
            msg: "Ingrese un título para buscar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        yield SearchState(isLoading: true);
        List<SueModel>? sues =
            await _sueController.getSuesByTitle(event.search);
        if (sues != null) {
          if (sues.isNotEmpty) {
            yield SearchState(
                isLoading: false,
                isError: false,
                message: "",
                sueModelList: sues);
          } else {
            yield SearchState(
                isLoading: false,
                isError: false,
                message: "No se encontraron Delitos",
                sueModelList: const []);
          }
        } else {
          yield SearchState(
              isLoading: false,
              isError: true,
              message: "Registro devuelve Null",
              sueModelList: const []);
        }
      }
    }
  }
}

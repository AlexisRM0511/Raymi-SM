import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/rest_services/sues/sue_controller.dart';
import '/rest_services/sues/sue_model.dart';
import '/rest_services/sues/sue_service.dart';
import '/rest_services/users/user_controller.dart';
import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SueController _sueController = SueController(SueService());

  HomeBloc() : super(HomeState(isLoading: true)) {
    add(SharedPreferencesEvent());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ProfileButtonPressedEvent) {
      Navigator.pushNamed(event.context, '/profile');
    }

    if (event is SignOutButtonPressedEvent) {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(event.context, '/');
    }

    if (event is GoSearchEvent) {
      Navigator.pushNamed(event.context, '/search');
    }

    if (event is GoSueEvent) {
      Navigator.pushNamed(event.context, '/sue');
    }

    if (event is GoSueDetailEvent) {
      Navigator.pushNamed(event.context, '/sue_detail', arguments: event.sue);
      Fluttertoast.showToast(
          msg: 'Denunciar ${event.sue.title}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    if (event is GoStatisticsEvent) {
      if (await canLaunchUrl(Uri.parse(
          "https://datastudio.google.com/u/0/reporting/2c7eb918-bddd-4e02-87d9-b5f9b569b364/page/XCZyC"))) {
        await launchUrl(
            Uri.parse(
                "https://datastudio.google.com/u/0/reporting/2c7eb918-bddd-4e02-87d9-b5f9b569b364/page/XCZyC"),
            mode: LaunchMode.inAppWebView);
      } else {
        Fluttertoast.showToast(
            msg: 'Error al cargar la visualización de datos',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    if (event is SharedPreferencesEvent) {
      SharedPreferences.getInstance().then((prefs) async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          prefs.setString('idFirebase', user.uid);
          UserModel? userModel =
              await UserController(UserService()).getUserByIdFirebase(user.uid);
          if (userModel != null) {
            prefs.setString('idUser', userModel.id.toString());
          }
        }
      });
    }

    if (event is ReloadSuesEvent) {
      yield HomeState(isLoading: true);
      List<SueModel>? sueList = await _sueController.getSues();
      if (sueList != null) {
        if (sueList.isNotEmpty) {
          yield HomeState(
              isLoading: false,
              isError: false,
              message: "",
              sueModelList: sueList);
        } else {
          yield HomeState(
              isLoading: false,
              isError: false,
              message: "No se encontraron Delitos",
              sueModelList: const []);
        }
      } else {
        yield HomeState(
            isLoading: false,
            isError: true,
            message: "Registro devuelve Null",
            sueModelList: const []);
      }
    }
  }
}

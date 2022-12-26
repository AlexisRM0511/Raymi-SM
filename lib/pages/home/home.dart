import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/components/button.dart';
import 'package:raymism/components/event_list.dart';
import 'package:raymism/components/image_logo.dart';
import 'package:raymism/components/spinner_loading.dart';
import 'package:raymism/components/label.dart';
import 'package:raymism/shared/colors.dart';
import '/pages/home/bloc/home_bloc.dart';
import '/pages/home/widgets/app_bar.dart';
import '/pages/home/widgets/dialog_confirm.dart';
import '/pages/home/widgets/input_redirect.dart';
import '/pages/home/widgets/event_info.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(ReloadEventsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return WillPopScope(
      onWillPop: () async =>
          await showMyDialog(
              "Saliendo de la aplicación",
              "¿Estás seguro de que quieres salir de la aplicación?",
              context) ??
          false,
      child: Scaffold(
          appBar: AppBarHome(
              profileOnPressed: () =>
                  homeBloc.add(ProfileButtonPressedEvent(context: context)),
              signOutOnPressed: () =>
                  homeBloc.add(SignOutButtonPressedEvent(context: context))),
          body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return Stack(children: [
              SafeArea(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: CustomColor.backgroundColor,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(children: [
                            InputRedirect(
                                hint: "Buscar",
                                icon: const Icon(Icons.search),
                                onPressed: () => homeBloc
                                    .add(GoSearchEvent(context: context))),
                            const ImageLogo(width: 0.5, height: 0.3),
                            const Label(
                                text: "¿Deseas registrar algún evento?"),
                            InputRedirect(
                                hint: "Registrar evento",
                                icon:
                                    const Icon(Icons.pending_actions_outlined),
                                onPressed: () =>
                                    homeBloc.add(GoEventEvent(context: context))),
                            const Label(
                                text: "¿Te perdiste? Te ayudamos a ubicarte"),
                            Button(
                                text: "Ver Mapa",
                                onPressed: () =>
                                    homeBloc.add(GoStatisticsEvent())),
                            EventInfo(
                                text: "Eventos Registrados",
                                onPressed: () =>
                                    homeBloc.add(ReloadEventsEvent())),
                            EventList(
                                eventModelList: state.eventModelList,
                                isLoading: state.isLoading),
                          ])))),
              SpinnerLoading(isLoading: state.isLoading)
            ]);
          })),
    );
  }
}

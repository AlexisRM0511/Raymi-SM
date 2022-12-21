import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/home/bloc/home_bloc.dart';
import '/pages/home/widgets/app_bar.dart';
import '/pages/home/widgets/button_statistics.dart';
import '/pages/home/widgets/dialog_confirm.dart';
import '/pages/home/widgets/image_logo.dart';
import '/pages/home/widgets/input_search.dart';
import '/pages/home/widgets/spinner_loading.dart';
import '/pages/home/widgets/sue_info.dart';
import '/pages/home/widgets/sue_list.dart';
import '/pages/home/widgets/text_info.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(ReloadSuesEvent());
    BlocProvider.of<HomeBloc>(context).add(SharedPreferencesEvent());
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
                      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
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
                            const ImageLogo(),
                            const TextInfo(
                                text: "¿Has presenciado algún delito?"),
                            InputRedirect(
                                hint: "Denunciar",
                                icon:
                                    const Icon(Icons.pending_actions_outlined),
                                onPressed: () =>
                                    homeBloc.add(GoSueEvent(context: context))),
                            const TextInfo(
                                text: "¿Deseas ver las estadísticas?"),
                            ButtonStatistics(
                                text: "Ver Estadísticas",
                                onPressed: () =>
                                    homeBloc.add(GoStatisticsEvent())),
                            SueInfo(
                                text: "Denuncias Realizadas",
                                onPressed: () =>
                                    homeBloc.add(ReloadSuesEvent())),
                            SueList(
                                sueModelList: state.sueModelList,
                                message: state.message,
                                isError: state.isError,
                                isLoading: state.isLoading),
                          ])))),
              SpinnerLoading(isLoading: state.isLoading)
            ]);
          })),
    );
  }
}

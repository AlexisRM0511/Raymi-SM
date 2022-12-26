import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raymism/components/button.dart';
import 'package:raymism/components/spinner_loading.dart';
import 'package:raymism/shared/colors.dart';
import 'package:raymism/shared/constants.dart';
import '/pages/home/widgets/event_info.dart';
import '/pages/profile/bloc/profile_bloc.dart';
import '/pages/profile/widgets/app_bar.dart';
import '../../components/event_list.dart';
import '/pages/profile/widgets/event_statistics.dart';
import '/pages/profile/widgets/text_profile_datos.dart';
import '/pages/profile/widgets/text_profile_name.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(UserFillEvent());
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBarProfile(
              onPressed: () => profileBloc
                  .add(LeadingIconButtonPressedEvent(context: context)),
              username: state.username),
          body: Stack(children: [
            SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: CustomColor.backgroundColor,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(children: [
                          TextProfileName(
                              text: '${state.name} ${state.lastname}'),
                          TextProfileDatos(
                              textDni: state.dni,
                              textEmail: state.email,
                              textPhone: state.phone,
                              textUsername: state.username),
                          Button(
                              text: Constants.updateUser,
                              onPressed: () => profileBloc.add(
                                  UpdateProfileButtonEvent(context: context))),
                          EventsStatistics(
                              eventMade: state.eventMade,
                              eventApproved: state.eventApproved),
                          EventInfo(
                              text: Constants.eventsForUser,
                              onPressed: () =>
                                  profileBloc.add(UserFillEvent())),
                          EventList(
                              eventModelList: state.eventModelList,
                              isLoading: state.isLoading)
                        ])))),
            SpinnerLoading(isLoading: state.isLoading)
          ]));
    });
  }
}

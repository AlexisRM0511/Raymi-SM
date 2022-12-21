import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/sue_detail/widgets/image_sue.dart';
import '/pages/sue_detail/widgets/text_sue_data.dart';
import '/pages/sue_detail/widgets/text_sue_info.dart';
import '/pages/sue_detail/widgets/text_sue_title.dart';

import '../../rest_services/sues/sue_model.dart';
import 'bloc/sue_detail_bloc.dart';
import 'widgets/app_bar.dart';

class SueDetail extends StatefulWidget {
  const SueDetail({Key? key}) : super(key: key);

  @override
  State<SueDetail> createState() => _SearchPageState();
}

class _SearchPageState extends State<SueDetail> {
  @override
  Widget build(BuildContext context) {
    SueModel params = ModalRoute.of(context)?.settings.arguments as SueModel;
    final sueDetailBloc = BlocProvider.of<SueDetailBloc>(context);

    return Scaffold(
        appBar: AppBarSueDetail(
            onPressed: () => sueDetailBloc
                .add(LeadingIconButtonPressedEvent(context: context)),
            title: params.title!),
        body: BlocBuilder<SueDetailBloc, SueDetailState>(
            builder: (context, state) {
          return Stack(children: [
            SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(children: [
                          ImageSue(image: params.photo!),
                          TextSueTitle(
                              idUser: params.user!,
                              title: params.title!,
                              status: params.status!,
                              onPressed: () => sueDetailBloc.add(GoSueEditEvent(
                                  context: context, sue: params))),
                          const TextSueInfo(text: 'Descripción:'),
                          TextSueData(text: params.description!),
                          const TextSueInfo(text: 'Fecha y Hora:'),
                          TextSueData(text: params.dateAndTime!),
                          const TextSueInfo(text: 'Ubicación:'),
                          TextSueData(text: params.location!),
                          const TextSueInfo(text: 'Reportado por:'),
                          TextSueData(text: params.user!.split("|")[0])
                        ]))))
          ]);
        }));
  }
}

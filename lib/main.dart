import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/firebase_options.dart';

import '/pages/sign_in/sign_in.dart';
import '/pages/sign_in/bloc/sign_in_bloc.dart';
import '/pages/sign_up/sign_up.dart';
import '/pages/sign_up/bloc/sign_up_bloc.dart';
import '/pages/home/home.dart';
import '/pages/home/bloc/home_bloc.dart';
import '/pages/search/search.dart';
import '/pages/search/bloc/search_bloc.dart';
import '/pages/profile/profile.dart';
import '/pages/profile/bloc/profile_bloc.dart';
import '/pages/profile_edit/profile_edit.dart';
import '/pages/profile_edit/bloc/profile_edit_bloc.dart';
import '/pages/event/event.dart';
import '/pages/event/bloc/event_bloc.dart';
import '/pages/event_detail/bloc/event_detail_bloc.dart';
import '/pages/event_detail/event_detail.dart';
import '/pages/event_edit/bloc/event_edit_bloc.dart';
import '/pages/event_edit/event_edit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SignInBloc>(create: (context) => SignInBloc()),
      BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
      BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
      BlocProvider<EventBloc>(create: (context) => EventBloc()),
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
      BlocProvider<ProfileEditBloc>(create: (context) => ProfileEditBloc()),
      BlocProvider<EventDetailBloc>(create: (context) => EventDetailBloc()),
      BlocProvider<EventEditBloc>(create: (context) => EventEditBloc())
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Raymi SM',
        initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/home',
        routes: {
          '/': (context) => BlocProvider.value(
              value: BlocProvider.of<SignInBloc>(context),
              child: const SignIn()),
          '/signup': (context) => BlocProvider.value(
              value: BlocProvider.of<SignUpBloc>(context),
              child: const SignUp()),
          '/home': (context) => BlocProvider.value(
              value: BlocProvider.of<HomeBloc>(context), child: const Home()),
          '/search': (context) => BlocProvider.value(
              value: BlocProvider.of<SearchBloc>(context),
              child: const Search()),
          '/event': (context) => BlocProvider.value(
              value: BlocProvider.of<EventBloc>(context), child: const Event()),
          '/profile': (context) => BlocProvider.value(
              value: BlocProvider.of<ProfileBloc>(context),
              child: const Profile()),
          '/profile_edit': (context) => BlocProvider.value(
              value: BlocProvider.of<ProfileEditBloc>(context),
              child: const ProfileEdit()),
          '/event_detail': (context) => BlocProvider.value(
              value: BlocProvider.of<EventDetailBloc>(context),
              child: const EventDetail()),
          '/event_edit': (context) => BlocProvider.value(
              value: BlocProvider.of<EventEditBloc>(context),
              child: const EventEdit())
        });
  }
}

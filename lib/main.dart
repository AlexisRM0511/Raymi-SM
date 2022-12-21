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
import '/pages/sue/sue.dart';
import '/pages/sue/bloc/sue_bloc.dart';
import '/pages/sue_detail/bloc/sue_detail_bloc.dart';
import '/pages/sue_detail/sue_detail.dart';
import '/pages/sue_edit/bloc/sue_edit_bloc.dart';
import '/pages/sue_edit/sue_edit.dart';

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
      BlocProvider<SueBloc>(create: (context) => SueBloc()),
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
      BlocProvider<ProfileEditBloc>(create: (context) => ProfileEditBloc()),
      BlocProvider<SueDetailBloc>(create: (context) => SueDetailBloc()),
      BlocProvider<SueEditBloc>(create: (context) => SueEditBloc())
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
          '/sue': (context) => BlocProvider.value(
              value: BlocProvider.of<SueBloc>(context), child: const Sue()),
          '/profile': (context) => BlocProvider.value(
              value: BlocProvider.of<ProfileBloc>(context),
              child: const Profile()),
          '/profile_edit': (context) => BlocProvider.value(
              value: BlocProvider.of<ProfileEditBloc>(context),
              child: const ProfileEdit()),
          '/sue_detail': (context) => BlocProvider.value(
              value: BlocProvider.of<SueDetailBloc>(context),
              child: const SueDetail()),
          '/sue_edit': (context) => BlocProvider.value(
              value: BlocProvider.of<SueEditBloc>(context),
              child: const SueEdit())
        });
  }
}

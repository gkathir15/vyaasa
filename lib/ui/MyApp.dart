import 'dart:async';

import 'package:fb_auth/data/blocs/auth/auth_bloc.dart';
import 'package:fb_auth/data/blocs/auth/auth_event.dart';
import 'package:fb_auth/data/blocs/auth/auth_state.dart';
import 'package:fb_auth/data/classes/app.dart';
import 'package:fb_auth/data/classes/auth_user.dart';
import 'package:fb_auth/data/services/auth/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vyaasa/ui/SignUpWithEmail.dart';

import '../Consts.dart';
import '../route/Routes.dart';
import 'HomePage.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final _app = FbApp(
    apiKey: "API_KEY",
    authDomain: "AUTH_DOMAIN",
    databaseURL: "DATABASE_URL",
    projectId: "PROJECT_ID",
    storageBucket: "STORAGE_BUCKET",
    messagingSenderId: "MESSAGING_SENDER_ID",
    appId: "APP_ID",
  );

  AuthBloc _auth;
  StreamSubscription<AuthUser> _userChanged;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(builder: (_) => _auth),
        ],
        child: MaterialApp(
            onGenerateRoute: Routes.sailor.generator(),
            navigatorKey: Routes.sailor.navigatorKey,
            title: app_name,
            theme: ThemeData(
              accentColor: Colors.deepOrangeAccent,
              primaryColor: Colors.deepOrangeAccent,
              brightness: Brightness.light,
              fontFamily: 'Montserrat',
            ),
            darkTheme: ThemeData(brightness: Brightness.dark),
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is LoggedInState) {
                  return MyHomePage(title: app_name);
                }
                return SignUpWithEmail();
              },
            )));
  }

  @override
  void dispose() {
    _auth.close();
    _userChanged?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _auth = AuthBloc(saveUser: _saveUser, deleteUser: _deleteUser, app: _app);
    _auth.add(CheckUser());
    final _fbAuth = FBAuth(_app);
    _userChanged = _fbAuth.onAuthChanged().listen((user) {
      _auth.add(UpdateUser(user));
    });
  }

  static _deleteUser() async {}

  static _saveUser(user) async {}
}

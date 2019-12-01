import 'package:fb_auth/data/blocs/auth/auth_bloc.dart';
import 'package:fb_auth/data/classes/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vyaasa/route/Routes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AuthUser authUser = AuthBloc.currentUser(context);
    AuthBloc authBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3.0,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  Text(authUser.displayName == null
                      ? authUser.email
                      : authUser.displayName),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Logout"),
                  )
                ],
              ),
              decoration: BoxDecoration(),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('My Scripts'),
              onTap: () {
                Navigator.pop(context);
                Routes.sailor
                    .navigate("/profile", params: {"title": "profile"});
                // Then close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.mobile_screen_share),
              title: Text('Shared'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.live_help),
              title: Text('Help'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('About'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New Scrip',
        child: Icon(Icons.note_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

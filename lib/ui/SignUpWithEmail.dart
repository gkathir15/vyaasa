import 'package:fb_auth/data/blocs/auth/auth_bloc.dart';
import 'package:fb_auth/data/blocs/auth/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpWithEmail extends StatelessWidget {
  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  static String email, password;
  static TextEditingController emailController, passwordContoller;
  // static BuildContext _context;

  @override
  Widget build(BuildContext context) {
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
    //  _context = context;
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0, child: FlutterLogo()),
              googleSign(context, authBloc),
              facebookSiginIn(context, authBloc),
              SizedBox(height: 45.0),
              emailField,
              SizedBox(height: 25.0),
              passwordField,
              SizedBox(
                height: 35.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  loginButton(context, authBloc),
                  createAcc(context, authBloc)
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final emailField = TextField(
    controller: emailController,
    onChanged: (String txt) {
      email = txt;
    },
    style: style,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final passwordField = TextField(
    controller: passwordContoller,
    obscureText: true,
    onChanged: (String txt) {
      password = txt;
    },
    style: style,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  Widget loginButton(BuildContext context, AuthBloc authBloc) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).accentColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          authBloc.add(LoginEvent(email, password));
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget createAcc(BuildContext context, AuthBloc authBloc) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).accentColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          authBloc.add(CreateAccount(email, password, displayName: email));
        },
        child: Text("SignUp",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget googleSign(BuildContext context, AuthBloc authBloc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).accentColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            GoogleSignInAuthentication credential =
                await getGoogleSignINCredentials();
            authBloc.add(LoginGoogle(
                accessToken: credential.accessToken,
                idToken: credential.idToken));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Image(
                    width: 20.0,
                    height: 20.0,
                    image: AssetImage(
                      "graphics/google-logo.png",
                      package: "flutter_auth_buttons",
                    )),
              ),
              Text("Sign in with Google",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget facebookSiginIn(BuildContext context, AuthBloc authBloc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).accentColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            FacebookLoginResult result =
                await initiateFacebookLogin(context, authBloc);
//            if (FacebookLoginStatus.loggedIn == result.status)
//              authBloc.add(LoginFacebook(
//                  accessToken: result.accessToken.token,
//                  idToken: result.accessToken.userId));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Image(
                    width: 20.0,
                    height: 20.0,
                    image: AssetImage(
                      "graphics/flogo-HexRBG-Wht-100.png",
                      package: "flutter_auth_buttons",
                    )),
              ),
              Text("Sign in with Facebook",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title),
            ],
          ),
        ),
      ),
    );
  }

  getGoogleSignINCredentials() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleSignInAuthentication.accessToken,
//      idToken: googleSignInAuthentication.idToken,
//    );
    return googleSignInAuthentication;
  }

  initiateFacebookLogin(BuildContext context, AuthBloc authBloc) async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    FirebaseAuth auth = FirebaseAuth.instance;

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Something Went wrong with FB'),
        ));
        return facebookLoginResult;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Cancelled'),
        ));
        return facebookLoginResult;
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        AuthCredential authCredential = FacebookAuthProvider.getCredential(
            accessToken: facebookLoginResult.accessToken.token);
        auth.signInWithCredential(authCredential);
        authBloc.add(LoginInFacebook(authCredential: authCredential));
        return facebookLoginResult;
        //onLoginStatusChanged(true);
        break;
    }
  }
}

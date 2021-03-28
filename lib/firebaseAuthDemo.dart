import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
      Widget>[
      Container(
      child: Stack(
          children: <Widget>[
          Container(
          padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
      child: Text(
        'Signup',
        style:
        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
      ),
    ),
    Container(
    padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
    child: Text(
    '.',
    style: TextStyle(
    fontSize: 80.0,
    fontWeight: FontWeight.bold,
    color: Colors.green),
    ),
    )
    ],
    ),
    ),
    Container(
    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
    child: Column(
    children: <Widget>[
    TextField(
    decoration: InputDecoration(
    labelText: 'EMAIL',
    labelStyle: TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: Colors.grey),
    // hintText: 'EMAIL',
    // hintStyle: ,
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.green))),
    ),
    SizedBox(height: 10.0),
    TextField(
    decoration: InputDecoration(
    labelText: 'PASSWORD ',
    labelStyle: TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: Colors.grey),
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.green))),
    obscureText: true,
    ),
    SizedBox(height: 10.0),
    TextField(
    decoration: InputDecoration(
    labelText: 'NICK NAME ',
    labelStyle: TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: Colors.grey),
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.green))),
    ),
    SizedBox(height: 50.0),
    Container(
    height: 40.0,
    child: Material(
    borderRadius: BorderRadius.circular(20.0),
    shadowColor: Colors.greenAccent,
    color: Colors.green,
    elevation: 7.0,
    child: GestureDetector(
    onTap: () async {

      if (_formKey.currentState.validate()) {
        _signInWithEmailAndPassword();
      }
    },
    child: Center(
    child: Text(
    'SIGNUP',
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat'),
    ),
    ),
    ),
    )),
    SizedBox(height: 20.0),
    Container(
    height: 40.0,
    color: Colors.transparent,
    child: Container(
    decoration: BoxDecoration(
    border: Border.all(
    color: Colors.black,
    style: BorderStyle.solid,
    width: 1.0),
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(20.0)),
    child: InkWell(
    onTap: () {
    Navigator.of(context).pop();
    },
    child:

    Center(
    child: Text('Go Back',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat')),
    ),


    ),
    ),
    ),
    ],
      ),
    )
  ],
    ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MainPage(
          user: user,
        );
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }
}


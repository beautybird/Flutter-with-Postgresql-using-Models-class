import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/models/model_user.dart';
import 'package:flutter_db/shared_widgets/buttons.dart';
import 'package:flutter_db/shared_widgets/form_text_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  /*...Create a controller for every field ...*/
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /*...Make sure the field has value entered ...*/
  String emailValue = '';
  String _emailLatestValue() {
    return emailValue = ((_emailController.text).isNotEmpty &&
            (_emailController.text).length > 0
        ? _emailController.text
        : '');
  }

  String passwordValue = '';
  String _passwordLatestValue() {
    return passwordValue = ((_passwordController.text).isNotEmpty &&
            (_passwordController.text).length > 0
        ? _passwordController.text
        : '');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.addListener(() {
      _emailLatestValue();
    });
    _passwordController.addListener(() {
      _passwordLatestValue();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          reverse: false,
          controller: ScrollController(),
          primary: false,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                minWidth: 380.0,
                maxWidth: 420.0,
                minHeight: 250.0,
                maxHeight: 300.0,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('res/flowersonsea.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormTextFieldStandard(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    icon: Icons.email,
                    tooltip: "Email",
                    maxLines: 1,
                    formTextFieldLabel: "Email Address",
                    validate: (stringEmailValue) =>
                        stringEmailValue!.isEmpty == true ? "Email" : null,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FormTextFieldStandardObsecured(
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontColor: Colors.black,
                    icon: Icons.security,
                    tooltip: "Password",
                    maxLines: 1,
                    formTextFieldLabel: "Password",
                    validate: (stringPassValue) =>
                        stringPassValue!.isEmpty == true
                            ? "Add Password"
                            : null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      minWidth: 380.0,
                      maxWidth: 420.0,
                      minHeight: 50.0,
                      maxHeight: 50.0,
                    ),
                    child: StandardElevatedButton(
                      style: ButtonStyle(),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      onPressed: () {
                        processLoginData(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      minWidth: 380.0,
                      maxWidth: 420.0,
                      minHeight: 50.0,
                      maxHeight: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Text(
                              "Register Account",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            child: Text(
                              'Seller Shop',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/sellerShop');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> processLoginData(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      ModelsUsers()
          .userLoginModel(emailValue, passwordValue)
          .then((loginFuture) {
        if (loginFuture.toString().contains('buy')) {
          Navigator.pushNamed(context, '/buyerAccount');
          setState(() {
            _emailController.clear();
            _passwordController.clear();
          });
        } else if (loginFuture.toString().contains('sel')) {
          Navigator.pushNamed(context, '/sellerAccount');
          setState(() {
            _emailController.clear();
            _passwordController.clear();
          });
        } else if (loginFuture.toString().contains('not')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                    color: Colors.red, width: 0.5, style: BorderStyle.solid),
                content: Text(
                  "Email Not Registered",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _emailController.clear();
            _passwordController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/');
            });
          });
        } else if (loginFuture.contains('fai')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                  color: Colors.red,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
                content: Text(
                  "Login Failed..wrong email or password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _emailController.clear();
            _passwordController.clear();
            Timer(Duration(seconds: 3), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        } else if (loginFuture.contains('exc')) {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                shape: Border.all(
                    color: Colors.orange, width: 0.5, style: BorderStyle.solid),
                content: Text(
                  "Something Went Wrong",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _emailController.clear();
            _passwordController.clear();
            Timer(Duration(seconds: 4), () {
              Navigator.pushNamed(context, '/login');
            });
          });
        }
      }).catchError((err) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              elevation: 10.0,
              shape: Border.all(
                  color: Colors.orange, width: 0.5, style: BorderStyle.solid),
              content: Text(
                "Something Went Wrong",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
          _emailController.clear();
          _passwordController.clear();
          Timer(Duration(seconds: 4), () {
            Navigator.pushNamed(context, '/login');
          });
        });
      }).whenComplete(() => null);
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            elevation: 10.0,
            shape: Border.all(
              color: Colors.orange,
              width: 0.5,
              style: BorderStyle.solid,
            ),
            content: Text(
              "Fill All Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
        _emailController.clear();
        _passwordController.clear();
        Timer(Duration(seconds: 4), () {
          Navigator.pushNamed(context, '/login');
        });
      });
    }
  }

  loginFieldsData() {}
}

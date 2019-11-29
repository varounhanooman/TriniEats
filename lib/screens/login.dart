import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../bloc/auth_bloc.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Map<String, dynamic> _formData = {'email': null, 'password': null};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthBloc>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: targetWidth,
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 60.0,
                    child: Center(
                      child: Text(
                        'Trini Eats',
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  _buildEmailTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  SizedBox(
                    height: 40.0,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(child: Text('Login')),
                    ),
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      Navigator.of(context).pushNamed('/home');
                      // _submitForm(model.login);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        onFieldSubmitted: (String value) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextController,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        onSaved: (String value) {
          _formData['email'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        onFieldSubmitted: (String value) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: 'Password',
        ),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordTextController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password field empty';
          }
        },
        onSaved: (String value) {
          _formData['password'] = value;
        },
      ),
    );
  }

  void _submitForm(Function login) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    Map<String, dynamic> successInformation;

    successInformation = await login(_formData['email'], _formData['password']);

    // if (successInformation['success']) {
    //   // Navigator.pushReplacementNamed(context, "/maps");
    //   Toast.show(successInformation['message'], context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // } else {
    //   Toast.show(successInformation['message'], context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }
  }
}

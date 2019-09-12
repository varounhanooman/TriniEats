import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                // hintText: 'Enter your email',
                labelText: 'Email *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.enhanced_encryption),
                // hintText: 'What do people call you?',
                labelText: 'Password *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Login'),
              color: Colors.blue[200],
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

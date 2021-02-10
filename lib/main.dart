import 'package:bloc_login/bloc.dart';
import 'package:bloc_login/first_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter BLoc Pattern'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Bloc();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<String>(
                    stream: _bloc.email,
                    builder: (context, snapshot) => TextField(
                      onChanged: _bloc.emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorText: snapshot.error,
                          border: OutlineInputBorder(),
                          hintText: 'Enter Email',
                          labelText: 'Email'),
                    ),
                  ),
                  SizedBox(height: 20),
                  StreamBuilder<String>(
                      stream: _bloc.password,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: _bloc.passwordChanged,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              errorText: snapshot.error,
                              hintText: 'Enter Password',
                              labelText: 'Password'),
                        );
                      }),
                  SizedBox(height: 20),
                  StreamBuilder<bool>(
                      stream: _bloc.submitCheck,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          onPressed: snapshot.hasData ? () => changeThePage() : null,
                          color: Colors.tealAccent,
                          child: Text('Submit'),
                        );
                      })
                ],
              ))),
    );
  }

  changeThePage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FirstScreen()));
  }
}

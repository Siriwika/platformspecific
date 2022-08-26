import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class User {
  User({required this.name, required this.tel});
  String name;
  String tel;
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/platforms');
  late User _user = User(name: "", tel: "");

  Future<void> _getUserData() async {
    try {
      final result = await platform.invokeMethod('getUserData');
      _user.name = result['name'];
      _user.tel = result['tel'];
      // print(result['tel']);
      // print(result.runtimeType);

    } on PlatformException catch (e) {
      _user.name = "Failed to get user data: '${e.message}'.";
    }

    setState(() {
      _user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    String username = _user.name.toString();
    String tel = _user.tel.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Get user data:',
            ),
            Text(
              username,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              tel,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserData,
        tooltip: 'search',
        child: const Icon(Icons.search),
      ),
    );
  }
}

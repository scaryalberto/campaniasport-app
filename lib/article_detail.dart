import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Map something;
  DetailPage(this.something);
  @override
  State<StatefulWidget> createState() {
    return SecondPageState(this.something);
  }
}
class SecondPageState extends State<DetailPage> {


  Map something;

  SecondPageState(this.something);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GeeksforGeeks')),
      body: Center(
        child: Text(
          something['fields']['title'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
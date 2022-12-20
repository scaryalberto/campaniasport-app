import 'package:flutter/material.dart';

class ResearchPage extends StatefulWidget {
  Map something;
  ResearchPage(this.something);
  @override
  State<StatefulWidget> createState() {
    return ResearchPageState();
  }
}
class ResearchPageState extends State<ResearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GeeksforGeeks')),
      body: Center(
        child: Text('casa',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
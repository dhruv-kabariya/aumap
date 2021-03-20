import 'package:flutter/material.dart';

import 'screen/mainscreen.dart';

void main() {
  runApp(AuMap());
}

class AuMap extends StatelessWidget {
  const AuMap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

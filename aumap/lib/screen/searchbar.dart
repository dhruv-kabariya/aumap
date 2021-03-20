import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key key}) : super(key: key);

  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 20,
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: 250,
          child: TextFormField(
            controller: search,
          ),
        ),
      ),
    );
  }
}

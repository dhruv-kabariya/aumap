import 'package:aumap/bloc/Search/search_bloc.dart';
import 'package:aumap/screen/maprender.dart';
import 'package:aumap/screen/searchbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);
  SearchBloc bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [MapRender(), SearchBar()],
    ));
  }
}

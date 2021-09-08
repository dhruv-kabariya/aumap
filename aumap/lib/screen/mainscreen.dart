import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/bloc/Search/search_bloc.dart';
import 'package:aumap/bloc/route/route_bloc.dart';
import 'package:aumap/bloc/show_mark/showmark_bloc.dart';
import 'package:aumap/screen/maprender.dart';
import 'package:aumap/screen/searchDrawer.dart';
import 'package:aumap/screen/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SearchBloc bloc = SearchBloc();

  ShowmarkBloc mark = ShowmarkBloc();
  RouteBloc routeBloc = RouteBloc();

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  AuthenticationBloc auth;

  @override
  Widget build(BuildContext context) {
    auth = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      key: scaffold,
      drawer: SearchDetail(
        scaffoldKey: scaffold,
      ),
      body: Container(
        child: Stack(
          children: [
            MapRender(bloc: mark, route: routeBloc),
            SearchBar(
              bloc: bloc,
              loc: mark,
              scaffoldkey: scaffold,
              routeBloc: routeBloc,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:aumap/bloc/Search/search_bloc.dart';
import 'package:aumap/bloc/route/route_bloc.dart';
import 'package:aumap/bloc/search_route/search_route_cubit.dart';
import 'package:aumap/bloc/show_mark/showmark_bloc.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/screen/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key key, this.bloc, this.loc, this.scaffoldkey, this.routeBloc})
      : super(key: key);

  final SearchRouteCubit searchRouteCubit = SearchRouteCubit()..search();
  final SearchBloc bloc;
  final ShowmarkBloc loc;
  final GlobalKey<ScaffoldState> scaffoldkey;
  final RouteBloc routeBloc;
  final TextEditingController search = TextEditingController();
  OverlayEntry searchResult;

  void markLocation(LocationPoint p) {
    search.text = p.name;
    searchResult.remove();
    loc.add(HighLight(locationPoint: p));
    // if (!scaffoldkey.currentState.isDrawerOpen) {
    //   scaffoldkey.currentState.openDrawer();
    // }
  }

  void sendQuery(String q) {
    if (q.isEmpty) {
      bloc.add(SearchNone());
    } else {
      bloc.add(SearchLocation(query: q));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 350,
      // height: 60,
      left: 10,
      top: 20,
      child: Card(
        elevation: 10,
        child: BlocBuilder(
            bloc: searchRouteCubit,
            // ignore: missing_return
            builder: (context, state) {
              if (state is RouteSearch) {
                return Container(
                  child: RouteField(
                    hight: 145,
                    iconAction: () {
                      bloc.add(SearchNone());

                      routeBloc.add(RouteCancel());
                      searchRouteCubit.search();
                    },
                    bloc: bloc,
                    routeBloc: routeBloc,
                  ),
                );
              } else if (state is SearchRouteInitial) {
                return Container(
                  child: SearchField(
                    hight: 75,
                    iconAction: () {
                      bloc.add(SearchNone());

                      searchRouteCubit.route();
                    },
                    bloc: bloc,
                    loc: loc,
                  ),
                );
              } else {
                return Container(
                  color: Colors.amber,
                );
              }
            }),
      ),
    );
  }
}

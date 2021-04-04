import 'package:aumap/bloc/Search/search_bloc.dart';
import 'package:aumap/bloc/route/route_bloc.dart';
import 'package:aumap/bloc/show_mark/showmark_bloc.dart';
import 'package:aumap/models/location_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  SearchField({Key key, this.hight, this.iconAction, this.bloc, this.loc})
      : super(key: key);

  final double hight;
  final Function iconAction;

  final SearchBloc bloc;
  final ShowmarkBloc loc;

  final TextEditingController search = TextEditingController();

  OverlayEntry searchResult;

  void markLocation(LocationPoint p) {
    search.text = p.name;

    bloc.add(LocationDetailsearch(location: p));
    loc.add(HighLight(locationPoint: p));
  }

  void showResult(BuildContext context) {
    searchResult = OverlayEntry(builder: (context) {
      return Positioned(
        left: 10,
        top: hight,
        child: Card(
          child: BlocBuilder(
              bloc: bloc,

              // ignore: missing_return
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Container(
                    height: 200,
                    width: 350,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text("Search Location In Ahmedabad University"),
                  );
                }
                if (state is SeachingLocation ||
                    state is LocationDetailSearching) {
                  return Container(
                    height: 200,
                    width: 350,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is SearchedLocation) {
                  if (state.location.isEmpty) {
                    return Container(
                      height: 200,
                      width: 350,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text("No Location Found In Ahmedabad University"),
                    );
                  } else {
                    return Container(
                      height: 200,
                      width: 350,
                      child: ListView.builder(
                          itemCount: state.location.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => markLocation(state.location[index]),
                              title: Text(
                                state.location[index].name,
                              ),
                            );
                          }),
                    );
                  }
                }
                if (state is LocationDetailSearched) {
                  return Container(
                    height: 700,
                    width: 350,
                    color: Colors.amber,
                    child: Text("This is Working"),
                  );
                }
              }),
        ),
      );
    });

    Overlay.of(context).insert(searchResult);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: search,
            onTap: () {
              showResult(context);
            },
            onChanged: sendQuery,
            decoration: InputDecoration(
                hintText: "Search Location",
                hintStyle: GoogleFonts.lato(fontSize: 18, color: Colors.grey),
                suffix: Icon(Icons.search)),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: 1,
          color: Colors.grey,
        ),
        BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              return Container(
                width: 41,
                padding: EdgeInsets.all(5),
                child:
                    state is SearchedLocation || state is LocationDetailSearched
                        ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              search.text = "";
                              bloc.add(SearchNone());
                              loc.add(LocationCancel());
                              searchResult.remove();
                            })
                        : IconButton(
                            icon: Icon(
                              Icons.directions,
                              color: Colors.blue,
                            ),
                            onPressed: iconAction),
              );
            })
      ],
    );
  }
}

class RouteField extends StatelessWidget {
  RouteField({Key key, this.hight, this.iconAction, this.bloc, this.routeBloc})
      : super(key: key);

  final double hight;
  final Function iconAction;

  final SearchBloc bloc;
  final RouteBloc routeBloc;

  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  LocationPoint start;
  LocationPoint destination;
  OverlayEntry searchResult;

  void markLocation(LocationPoint p) {
    startController.text = p.name;
    searchResult.remove();
    start = p;
    if (destination != null) {
      routeBloc.add(SearchRoute(start: start, destination: destination));
    }
  }

  void showResult(BuildContext context, Function selectAction) {
    searchResult = OverlayEntry(builder: (context) {
      return Positioned(
        left: 10,
        top: hight,
        child: Card(
          child: Container(
            height: 200,
            width: 350,
            child: BlocBuilder(
                bloc: bloc,

                // ignore: missing_return
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text("Search Location In Ahmedabad University"),
                    );
                  }
                  if (state is SeachingLocation) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchedLocation) {
                    if (state.location.isEmpty) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child:
                            Text("No Location Found In Ahmedabad University"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: state.location.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => selectAction(state.location[index]),
                              title: Text(
                                state.location[index].name,
                              ),
                            );
                          });
                    }
                  }
                }),
          ),
        ),
      );
    });

    Overlay.of(context).insert(searchResult);
  }

  void sendQuery(String q) {
    if (q.isEmpty) {
      bloc.add(SearchNone());
    } else {
      bloc.add(SearchLocation(query: q));
    }
  }

  void sendRouteQuery(LocationPoint dest) {
    searchResult.remove();
    destination = dest;
    destinationController.text = dest.name;
    if (start != null) {
      routeBloc.add(SearchRoute(start: start, destination: dest));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: startController,
                onTap: () {
                  if (Overlay.of(context).mounted) {
                    try {
                      searchResult.remove();
                    } catch (e) {
                      // print(Overlay.of(context).)
                      print(Overlay.of(context).mounted);
                      print("error");
                    }
                  }
                  showResult(context, markLocation);
                },
                onChanged: sendQuery,
                decoration: InputDecoration(
                    hintText: "Search Start Location",
                    hintStyle:
                        GoogleFonts.lato(fontSize: 18, color: Colors.grey),
                    suffix: Icon(Icons.search)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 1,
              color: Colors.grey,
            ),
            Container(
              width: 41,
              padding: EdgeInsets.all(5),
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.blue,
                  ),
                  onPressed: iconAction),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: destinationController,
                onTap: () {
                  if (Overlay.of(context).mounted) {
                    try {
                      searchResult.remove();
                    } catch (e) {
                      // print(Overlay.of(context).)
                      print(Overlay.of(context).mounted);
                      print("error");
                    }
                  }
                  showResult(context, sendRouteQuery);
                },
                onChanged: sendQuery,
                decoration: InputDecoration(
                    hintText: "Search Destination Location",
                    hintStyle:
                        GoogleFonts.lato(fontSize: 18, color: Colors.grey),
                    suffix: Icon(Icons.search)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

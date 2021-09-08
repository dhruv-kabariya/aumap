import 'dart:convert';
import 'dart:math';

import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/bloc/postreview/postreview_cubit.dart';
import 'package:aumap/bloc/detail/detail_bloc.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filepicker_windows/filepicker_windows.dart' as pickker;

class PostReview extends StatelessWidget {
  PostReview({
    Key key,
    this.location,
    this.detailBloc,
  }) : super(key: key);

  final LocationPoint location;
  final TextEditingController text = TextEditingController();
  int star = 0;
  final PostreviewCubit cubit = PostreviewCubit();
  final DetailBloc detailBloc;
  List<String> picturs = [];
  List<String> images = [];
  List<Widget> widgets = [];
  void handleImages() {
    var files = pickker.OpenFilePicker();
    files.filterSpecification = {
      'JPEG Files': '*.jpg;*.jpeg',
      'Bitmap Files': '*.bmp',
      'Png files': '*.png'
    };
    files.title = 'Select an image';
    final result = files.getFile();
    print(result.path);
    // images.add(result.path);
    picturs.add(base64Encode(result.readAsBytesSync()));
    widgets.insert(0, Image.file(result));
  }

  User user = AuthenticationBloc.user;

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widgets = [
      InkWell(
        onTap: () {
          handleImages();
        },
        child: Container(
          width: 100,
          height: 100,
          // color: Colors.grey[200],
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey[200], width: 2)),
          alignment: Alignment.center,
          // padding: EdgeInsets.all(20),
          child: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.blue,
            size: 25,
          ),
        ),
      )
    ];
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        width: 600,
        height: 360,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                location.name,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              child: Form(
                key: form,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 60,
                      child: BlocBuilder(
                          bloc: cubit,
                          builder: (context, state) {
                            return Column(
                              children: [
                                if (state is ShowError)
                                  Text(
                                    state.star_error,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color:
                                              !(state is PostreviewInitial) &&
                                                      star >= 1
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                        ),
                                        onPressed: () {
                                          star = 1;
                                          cubit.setStar(1);
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color:
                                              !(state is PostreviewInitial) &&
                                                      star >= 2
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                        ),
                                        onPressed: () {
                                          star = 2;
                                          cubit.setStar(2);
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color:
                                              !(state is PostreviewInitial) &&
                                                      star >= 3
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                        ),
                                        onPressed: () {
                                          star = 3;
                                          cubit.setStar(3);
                                        }),
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: !(state is PostreviewInitial) &&
                                                star >= 4
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        star = 4;
                                        cubit.setStar(4);
                                      },
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color:
                                              !(state is PostreviewInitial) &&
                                                      star >= 5
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                        ),
                                        onPressed: () {
                                          star = 5;
                                          cubit.setStar(5);
                                        }),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                    Container(
                      width: 600,
                      height: 100,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        validator: (text) {
                          if (text.length < 5) {
                            return "Review lenght must be more than 5";
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            hintText: "Write Review",
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),

                      width: 600,
                      // height: 200,
                      child: Wrap(children: widgets),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      print(user.username);

                      if (form.currentState.validate()) {
                        if (star > 1) {
                          detailBloc.add(
                            PostReviewEvent(
                              location,
                              {
                                "user": user.username,
                                "text": text.text,
                                "star": star,
                                if (picturs.length > 0)
                                  "review_pic": picturs
                                      .map((e) => {"file_name": e})
                                      .toList()
                              },
                            ),
                          );

                          Navigator.of(context).pop();
                        } else {
                          cubit.showError();
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      child: Text(
                        "Post",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

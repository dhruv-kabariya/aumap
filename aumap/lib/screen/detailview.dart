import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/bloc/detail/detail_bloc.dart';
import 'package:aumap/bloc/likecubit/like_cubit.dart';
import 'package:aumap/models/information.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/review.dart';
import 'package:aumap/screen/reviewpost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailView extends StatelessWidget {
  DetailView({Key key, @required this.location}) : super(key: key);

  final LocationPoint location;
  final DetailBloc bloc = DetailBloc();

  @override
  Widget build(BuildContext context) {
    bloc..add(GetLocationDetail(location));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 600,
      width: 350,
      // color: Colors.amber,
      child: ListView(
        children: [
          ImageShow(pictures: location.pictures),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    location.name,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ShowStar(star: location.avg_star),
                Container(
                  margin: EdgeInsets.only(top: 8, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Text(location.phone.toString()),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.public,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Text(location.website),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
            thickness: 1,
          ),
          Container(
            margin: EdgeInsets.only(top: 8, left: 5),
            child: Text(
              location.desciption,
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.black87),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
            thickness: 1,
          ),
          Container(
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_location_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text("Add Images")
                ],
              ),
            ),
          ),
          ReviewWidget(
            bloc: bloc,
            point: location,
          )
        ],
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key key,
    @required this.bloc,
    this.point,
  }) : super(key: key);

  final DetailBloc bloc;
  final LocationPoint point;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is LocationDetailFetching || state is DetailInitial) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          } else if (state is LocationDetailFetched) {
            // print(state.reviews[0].user.first_name.substring(0));
            return Container(
                child: Column(
              children: [
                ShowInformation(info: state.data),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => PostReview(
                                location: point,
                                detailBloc: bloc,
                              ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.border_color,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("Add Review")
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 5,
                  endIndent: 5,
                  thickness: 1,
                ),
                ReviewList(reviews: state.reviews)
              ],
            ));
          }
          return Container();
        });
  }
}

class ReviewList extends StatelessWidget {
  const ReviewList({Key key, this.reviews}) : super(key: key);

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          reviews.length, (index) => ShowReview(review: reviews[index])),
    );
  }
}

class ShowInformation extends StatelessWidget {
  const ShowInformation({Key key, @required this.info}) : super(key: key);

  final Information info;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
          title: Row(
            children: [
              Icon(
                Icons.watch_later_outlined,
                color: info.status ? Colors.green : Colors.red,
              ),
              Text(info.status ? "Open now :" : "Closed :"),
              Text(info.data[DateTime.now().weekday]["openingtime"].hour
                      .toString() +
                  "-" +
                  info.data[DateTime.now().weekday]["closingtime"].hour
                      .toString())
            ],
          ),
          children: List.generate(
              info.data.length,
              (index) => InfoData(
                    data: info.data[index],
                  ))),
    );
  }
}

class InfoData extends StatelessWidget {
  const InfoData({Key key, this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(data["weekday"].toString().split(".")[1] + "   "),
          Text(data["openingtime"].hour.toString() +
              "-" +
              data["closingtime"].hour.toString())
        ],
      ),
    );
  }
}

class ShowReview extends StatelessWidget {
  ShowReview({
    Key key,
    @required this.review,
  }) : super(key: key) {
    cubit = LikeCubit()..checkLike(review, AuthenticationBloc.user.username);
  }

  final Review review;

  LikeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepOrange,
                maxRadius: 20,
                child: Text(
                  review.user.first_name[0],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(review.user.first_name + " " + review.user.last_name)
            ],
          ),
          ShowStar(star: double.parse(review.star.toString())),
          Container(
              margin: EdgeInsets.only(top: 5, left: 5),
              child: Text(review.text)),
          if (review.picture.length > 0) ImageShow(pictures: review.picture),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: BlocBuilder<LikeCubit, LikeState>(
              bloc: cubit,
              builder: (context, state) {
                return InkWell(
                    onTap: state is Liking
                        ? null
                        : () {
                            cubit.toggleLike(review,
                                AuthenticationBloc.user.username, state);
                          },
                    child: Row(
                      children: [
                        Icon(
                          state is Liked
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${review.total_like}",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )
                      ],
                    ));
              },
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class ImageShow extends StatelessWidget {
  const ImageShow({
    Key key,
    @required this.pictures,
  }) : super(key: key);

  final List<String> pictures;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemCount: pictures.length,
          itemBuilder: (context, index) {
            return Container(
              child: Image.network(
                pictures[index],
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}

class ShowStar extends StatelessWidget {
  const ShowStar({
    Key key,
    @required this.star,
  }) : super(key: key);

  final double star;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 5),
      child: Row(
        children: [
          Text(
            star.toString().substring(0, 3),
            style: TextStyle(color: Colors.black87, fontSize: 13),
          ),
          Container(
              child: Row(
            children: [
              Icon(
                Icons.star,
                size: 13,
                color: star >= 1 ? Colors.amber : Colors.grey[400],
              ),
              Icon(
                Icons.star,
                size: 13,
                color: star >= 2 ? Colors.amber : Colors.grey[400],
              ),
              Icon(
                Icons.star,
                size: 13,
                color: star >= 3 ? Colors.amber : Colors.grey[400],
              ),
              Icon(
                Icons.star,
                size: 13,
                color: star >= 4 ? Colors.amber : Colors.grey[400],
              ),
              Icon(
                Icons.star,
                size: 13,
                color: star >= 5 ? Colors.amber : Colors.grey[400],
              ),
            ],
          ))
        ],
      ),
    );
  }
}

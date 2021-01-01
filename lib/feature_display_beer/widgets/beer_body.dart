import 'package:beer_app/feature_display_beer/bloc/beer_bloc.dart';
import 'package:beer_app/feature_display_beer/bloc/beer_event.dart';
import 'package:beer_app/feature_display_beer/bloc/beer_state.dart';
import 'package:beer_app/feature_display_beer/models/beer_model.dart';
import 'package:beer_app/feature_display_beer/widgets/beer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeerBody extends StatefulWidget {
  @override
  _BeerBodyState createState() => _BeerBodyState();
}

class _BeerBodyState extends State<BeerBody> {
  final List<BeerModel> _beers = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<BeerBloc, BeerState>(
        listener: (context, beerState) {
          if (beerState is BeerLoadingState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(beerState.message)));
          } else if (beerState is BeerSuccessState && beerState.beers.isEmpty) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('No more beers')));
          } else if (beerState is BeerErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(beerState.error)));
            BlocProvider.of<BeerBloc>(context).isFetching = false;
          }
          return;
        },
        builder: (context, beerState) {
          if (beerState is BeerInitialState ||
              beerState is BeerLoadingState && _beers.isEmpty) {
            return CircularProgressIndicator();
          } else if (beerState is BeerSuccessState) {
            _beers.addAll(beerState.beers);
            BlocProvider.of<BeerBloc>(context).isFetching = false;
            Scaffold.of(context).hideCurrentSnackBar();
          } else if (beerState is BeerErrorState && _beers.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<BeerBloc>(context)
                      ..isFetching = true
                      ..add(BeerFetchEvent());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(beerState.error, textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !BlocProvider.of<BeerBloc>(context).isFetching) {
                  BlocProvider.of<BeerBloc>(context)
                    ..isFetching = true
                    ..add(BeerFetchEvent());
                }
              }),
            itemBuilder: (context, index) => BeerListItem(_beers[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _beers.length,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

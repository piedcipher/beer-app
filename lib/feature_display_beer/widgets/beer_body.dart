import 'package:beer_app/feature_display_beer/bloc/beer_bloc.dart';
import 'package:beer_app/feature_display_beer/bloc/beer_event.dart';
import 'package:beer_app/feature_display_beer/bloc/beer_state.dart';
import 'package:beer_app/feature_display_beer/models/beer_model.dart';
import 'package:beer_app/feature_display_beer/widgets/beer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeerBody extends StatelessWidget {
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
          }
          return;
        },
        builder: (context, beerState) {
          if (beerState is BeerInitialState ||
              beerState is BeerLoadingState && _beers.isEmpty) {
            return CircularProgressIndicator();
          } else if (beerState is BeerSuccessState) {
            _beers.addAll(beerState.beers);
            context.bloc<BeerBloc>().isFetching = false;
            Scaffold.of(context).hideCurrentSnackBar();
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !context.bloc<BeerBloc>().isFetching) {
                  context.bloc<BeerBloc>()
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
}

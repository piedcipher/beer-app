import 'package:beer_app/feature_display_beer/bloc/beer_bloc.dart';
import 'package:beer_app/feature_display_beer/bloc/beer_event.dart';
import 'package:beer_app/feature_display_beer/repository/beer_repository.dart';
import 'package:beer_app/feature_display_beer/widgets/beer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayBeerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BeerBloc(
        beerRepository: BeerRepository(),
      )..add(BeerFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Beers \u{1F37A}'),
        ),
        body: BeerBody(),
      ),
    );
  }
}

import 'package:beer_app/feature_display_beer/models/beer_model.dart';
import 'package:flutter/material.dart';

class BeerListItem extends StatelessWidget {
  final BeerModel beer;

  const BeerListItem(this.beer);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(beer.name),
      subtitle: Text(beer.tagline),
      childrenPadding: const EdgeInsets.all(16),
      leading: Container(
        margin: EdgeInsets.only(top: 8),
        child: Text(beer.id.toString()),
      ),
      children: [
        Text(
          beer.description,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        beer.imageUrl == null
            ? Container()
            : Image.network(
                beer.imageUrl!,
                loadingBuilder: (context, widget, imageChunkEvent) {
                  return imageChunkEvent == null
                      ? widget
                      : CircularProgressIndicator();
                },
                height: 300,
              ),
      ],
    );
  }
}

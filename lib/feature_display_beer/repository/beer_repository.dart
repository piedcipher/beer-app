import 'package:http/http.dart' as http;

class BeerRepository {
  static final BeerRepository _beerRepository = BeerRepository._();
  static const int _perPage = 10;

  BeerRepository._();

  factory BeerRepository() {
    return _beerRepository;
  }

  Future<dynamic> getBeers({
    required int page,
  }) async {
    try {
      return await http.get(
        Uri.parse(
          'https://api.punkapi.com/v2/beers?page=$page&per_page=$_perPage',
        ),
      );
    } catch (e) {
      return e.toString();
    }
  }
}

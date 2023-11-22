abstract class CountriesEvent {
  const CountriesEvent();
}

class GetCountriesEvent extends CountriesEvent {
  const GetCountriesEvent();
}

class SearchCountriesEvent extends CountriesEvent {
  final String query;
  const SearchCountriesEvent(this.query);
}

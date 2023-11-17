import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/domain/entities/country_entities/country_entity.dart';

abstract class CountriesState extends Equatable {
  final List<CountryEntity>? products;
  final DioException? error;

  const CountriesState({this.products, this.error});

  @override
  List<Object?> get props => [products, error];
}

class CountriesInit extends CountriesState {
  const CountriesInit();
}

// class CountriesEmpty extends CountriesState {
//   const CountriesEmpty();
// }

class CountriesLoaded extends CountriesState {
  const CountriesLoaded(List<CountryEntity> products)
      : super(products: products);
}

class CountriesError extends CountriesState {
  const CountriesError(DioException error) : super(error: error);
}

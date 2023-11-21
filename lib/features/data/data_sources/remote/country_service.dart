import 'package:dio/dio.dart';

import '../../model/country_models/country_model.dart';

class CountryService {
  final dio = Dio();
  final api = "https://restcountries.com/v3.1/all/";
  final searchApi = "https://restcountries.com/v3.1/name/";

  Future<Response<List<CountryModel>>> getListCountries() async {
    final response = await dio.get(api);
    final dataList = response.data as List<dynamic>;
    final listCountry = dataList.map((e) => CountryModel.fromJson(e)).toList();

    return Response<List<CountryModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: listCountry,
    );
  }

  Future<Response<List<CountryModel>>> searchCountries(String query) async {
    final response;
    if (query == "") {
      response = await dio.get(api);
    } else {
      response = await dio.get("$searchApi$query");
    }
    final dataList = response.data as List<dynamic>;
    final listSearchedCountry =
        dataList.map((e) => CountryModel.fromJson(e)).toList();

    return Response<List<CountryModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: listSearchedCountry,
    );
  }
}

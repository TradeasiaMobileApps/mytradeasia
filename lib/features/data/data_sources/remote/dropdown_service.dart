import 'package:dio/dio.dart';
import 'package:mytradeasia/core/constants/constants.dart';
import 'package:mytradeasia/features/data/model/dropdown_models/dropdown_currency_model.dart';
import 'package:mytradeasia/features/data/model/dropdown_models/dropdown_incoterm_model.dart';
import 'package:mytradeasia/features/data/model/dropdown_models/dropdown_uom_model.dart';

class DropdownService {
  final dio = Dio();

  Future<Response<List<DropdownIncotermModel>>> getIncoterm() async {
    final response = await dio.get("${newTradeasiaApi}getDropDown/incoterm");
    final data = response.data["data"]["result"] as List<dynamic>;
    final dataMapped =
        data.map((e) => DropdownIncotermModel.fromJson(e)).toList();

    return Response<List<DropdownIncotermModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: dataMapped,
    );
  }

  Future<Response<List<DropdownUomModel>>> getUom() async {
    final response = await dio.get("${newTradeasiaApi}getDropDown/uom");
    final data = response.data["data"]["result"] as List<dynamic>;
    final dataMapped = data.map((e) => DropdownUomModel.fromJson(e)).toList();

    return Response<List<DropdownUomModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: dataMapped,
    );
  }

  Future<Response<List<DropdownCurrencyModel>>> getCurrency() async {
    final response = await dio.get("${newTradeasiaApi}getDropDown/currency");
    final data = response.data["data"]["result"] as List<dynamic>;
    final dataMapped =
        data.map((e) => DropdownCurrencyModel.fromJson(e)).toList();

    return Response<List<DropdownCurrencyModel>>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: dataMapped,
    );
  }
}

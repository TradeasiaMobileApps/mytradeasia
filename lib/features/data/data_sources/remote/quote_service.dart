import 'package:dio/dio.dart';
import 'package:mytradeasia/features/data/model/quote_models/quote_model.dart';

class QuoteService {
  final dio = Dio();

  Future<Response<QuoteModel>> getQuote(int id) async {
    const String url = "http://localhost:3000/mytradeasia/quote/getQuote";

    final response = await dio.post(
      url,
      data: {"quote_id": id.toString()},
    );

    var rawData = response.data["payload"]["datas"];
    var data = rawData.map((e) => QuoteModel.fromJson(e));
    return Response<QuoteModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: data,
    );
  }
}

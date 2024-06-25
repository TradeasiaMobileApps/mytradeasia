import 'package:dio/dio.dart';
import 'package:mytradeasia/features/data/model/sales_force_login_models/sales_force_login_model.dart';

class SalesforceLoginService {
  final dio = Dio();

  Future<Response<SalesforceLoginModel>> postSalesforce() async {
    String clientId =
        "3MVG9SM6_sNwRXqvilLdlZtTOR_ZK3HrAugrl.YUGMvo.qn0nRTtL9upffxdnWZXfn6PfYB0C4SAR8FnwG1BI";
    String clientSecret =
        "48BC5C2BBC7EA1930E52930A173F6E5EEA2EFFFD17656D9714D5B290A43C42B0";

    String userName = "mustofaalisahid@gmail.com.newmind";
    String passwordSalesforce = "Salesforce.1";

    String urlSalesforce =
        "http://tradeasia.vn/api/token-sf?client_secret=48BC5C2BBC7EA1930E52930A173F6E5EEA2EFFFD17656D9714D5B290A43C42B0";

    final response = await dio.get(
      urlSalesforce,
      // options: Options(
      //   headers: {
      //     "key": "Content-Type",
      //     "value": "application/json",
      //     "type": "text"
      //   },
      // ),
    );
    final data = response.data;
    print(data);

    // final dataMapped = data.map((e) => SalesforceLoginModel.fromJson(e));

    return Response<SalesforceLoginModel>(
      statusCode: response.statusCode,
      requestOptions: response.requestOptions,
      data: SalesforceLoginModel.fromJson(data),
    );
  }
}

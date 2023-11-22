import 'package:mytradeasia/features/domain/entities/country_entities/country_entity.dart';

class CountryModel extends CountryEntity {
  // final String? name;
  // final String? codeCountry;
  // final String? phoneCode;
  // final String? flagUrl;

  const CountryModel({
    String? name,
    String? codeCountry,
    String? phoneCode,
    String? flagUrl,
  }) : super(
          name: name,
          codeCountry: codeCountry,
          phoneCode: phoneCode,
          flagUrl: flagUrl,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    var suffix =
        json["idd"]["suffixes"] == null ? "" : json["idd"]["suffixes"][0];
    return CountryModel(
      name: json["name"]["common"],
      codeCountry: json["cca2"],
      phoneCode: "${json["idd"]["root"]}$suffix",
      flagUrl: json["flags"]["png"],
    );
  }
}

import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_currency_entity.dart';

class DropdownCurrencyModel extends DropdownCurrencyEntity {
  const DropdownCurrencyModel({
    required int id,
    required String currency,
    required String countryName,
  }) : super(id: id, currency: currency, countryName: countryName);

  factory DropdownCurrencyModel.fromJson(Map<String, dynamic> json) =>
      DropdownCurrencyModel(
          id: json["id"],
          currency: json["currency"],
          countryName: json["country_name"]);
}

import 'package:equatable/equatable.dart';

class DropdownCurrencyEntity extends Equatable {
  final int id;
  final String currency;
  final String countryName;

  const DropdownCurrencyEntity({
    required this.id,
    required this.currency,
    required this.countryName,
  });

  @override
  List<Object?> get props => [
        id,
        currency,
        countryName,
      ];
}

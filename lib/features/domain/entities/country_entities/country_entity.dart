import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String? name;
  final String? codeCountry;
  final String? phoneCode;
  final String? flagUrl;

  const CountryEntity({
    this.name,
    this.codeCountry,
    this.phoneCode,
    this.flagUrl,
  });

  @override
  List<Object?> get props {
    return [
      name,
      codeCountry,
      phoneCode,
      flagUrl,
    ];
  }
}

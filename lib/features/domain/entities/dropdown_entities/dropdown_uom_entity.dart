import 'package:equatable/equatable.dart';

class DropdownUomEntity extends Equatable {
  final int id;
  final String uomName;

  const DropdownUomEntity({required this.id, required this.uomName});

  @override
  List<Object?> get props => [id, uomName];
}

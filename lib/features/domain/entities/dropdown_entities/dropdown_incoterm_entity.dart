import 'package:equatable/equatable.dart';

class DropdownIncotermEntity extends Equatable {
  final int id;
  final String incotermName;

  const DropdownIncotermEntity({
    required this.id,
    required this.incotermName,
  });

  @override
  List<Object?> get props => [id, incotermName];
}

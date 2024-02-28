import 'package:equatable/equatable.dart';

class AllProductEntities extends Equatable {
  const AllProductEntities({
    required this.id,
    required this.productname,
    required this.productimage,
    required this.hsCode,
    required this.casNumber,
  });

  final String? id;
  final String? productname;
  final String? productimage;
  final String? hsCode;
  final String? casNumber;

  @override
  List<Object?> get props => [id, productname, productimage, hsCode, casNumber];
}

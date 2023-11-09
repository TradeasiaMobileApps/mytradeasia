import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_cp_model.dart';

class SalesforceCPEntity extends Equatable {
  int? totalSize;
  bool? done;
  List<CPRecords>? records;

  SalesforceCPEntity({this.totalSize, this.done, this.records});

  @override
  List<Object?> get props {
    return [totalSize, done, records];
  }
}

import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_bl_model.dart';

class SearatesBLEntity extends Equatable {
  String? status;
  String? message;
  BLData? data;

  SearatesBLEntity({this.status, this.message, this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

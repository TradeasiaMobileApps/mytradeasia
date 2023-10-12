import 'package:equatable/equatable.dart';
import 'package:mytradeasia/features/data/model/searates_model/searates_bl_model.dart';

class SearatesBLEntity extends Equatable {
  String? status;
  String? message;
  BLData? data;

  SearatesBLEntity({this.status, this.message, this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

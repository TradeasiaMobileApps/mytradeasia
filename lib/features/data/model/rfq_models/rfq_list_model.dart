import 'package:mytradeasia/features/data/model/rfq_models/rfq_model.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_list_entity.dart';

class RfqListModel extends RfqListEntity {
  const RfqListModel(
      {List<RfqModel>? submitted,
      List<RfqModel>? quoted,
      List<RfqModel>? rejected,
      List<RfqModel>? approved})
      : super(
            submitted: submitted,
            quoted: quoted,
            rejected: rejected,
            approved: approved);

  factory RfqListModel.fromJson(List<List<dynamic>> json) {
    return RfqListModel(
      submitted: json[0].isNotEmpty
          ? json[0].map((e) => RfqModel.fromJson(e)).toList()
          : [],
      quoted: json[1].isNotEmpty
          ? json[1].map((e) => RfqModel.fromJson(e)).toList()
          : [],
      rejected: json[2].isNotEmpty
          ? json[2].map((e) => RfqModel.fromJson(e)).toList()
          : [],
      approved: json[3].isNotEmpty
          ? json[3].map((e) => RfqModel.fromJson(e)).toList()
          : [],
    );
  }
}
